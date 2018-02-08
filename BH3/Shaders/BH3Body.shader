Shader "BH3/BH3Body" //from 1389
{
	Properties
	{
		_InvertUV("InvertUV", float) = 0 //这个自己加的，因为发现用profiler导出的模型的uv.y是反的
		_MainTex ("MainTex", 2D) = "white" {}
		_LightMapTex("LightMapTex", 2D) = "white" {}
		_Color("Color", Vector) = (0.9313,0.9313,0.9313,0.95)
		_LightArea("LightArea", float) = 0.51
		_SecondShadow("SecondShadow", float) = 0.51
		_FirstShadowMultColor("FirstShadowMultColor", Vector) = (0.7294,0.6,0.6509,1)
		_SecondShadowMultColor("SecondShadowMultColor", Vector) = (0.6509,0.4509,0.5490,1)
		_Shiniess("Shiniess", float) = 10
		_SpecMulti("SpecMulti", float) = 0.2
		_LightSpecColor("LightSpecColor", Vector) = (1,1,1,1)
		_BloomFactor("BloomFactor", float) = 1

		_UsingDitherAlpha("UsingDitherAlpha", float) = 0
		_DitherAlpha("DitherAlpha", float) = 0.5
		_UsingBloomMask("UsingBloomMask", float) = 0
		_BloomMaskTex("BloomMaskTex", 2D) = "white" {}

		_Emission("Emission", float) = 1
		_EmissionColor("EmissionColor", color) = (255,255,255,255)
		_EmissionBloomFactor("EmissionBloomFactor", float) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		ZWrite On

		Pass
		{
			Name "ForwardBase"
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma multi_compile_fwdbase
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 color: COLOR;
				float3 normal: Normal;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 color0: COLOR;
				float halfLambert: COLOR1;
				float3 worldNormal: TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float2 uvBloom: TEXCOORD5;
				float4 texcoord3: TEXCOORD3;

			};

			float _InvertUV;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _LightMapTex;
			float4 _LightMapTex_ST;

			float4 _Color;

			float _LightArea;
			float _SecondShadow;
			float4 _FirstShadowMultColor;
			float4 _SecondShadowMultColor;
			float _Shiniess;
			float _SpecMulti;
			float4 _LightSpecColor;
			float _BloomFactor;

			float _UsingDitherAlpha;
			float _DitherAlpha;
			float _UsingBloomMask;
			sampler2D _BloomMaskTex;
			float4 _BloomMaskTex_ST;

			float _Emission;
			float4 _EmissionColor;
			float _EmissionBloomFactor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				if(asint(_InvertUV) != 0)
				{
					o.uv.y = 1 - o.uv.y;
				}
				o.color0 = v.color;
				//o.color0 = float4(v.normal,1);

				int iUsingBloomMask = asint(_UsingBloomMask);
				o.uvBloom = (iUsingBloomMask != 0) ? TRANSFORM_TEX(v.uv, _BloomMaskTex) : float2(0,0);

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldPos = worldPos;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				worldNormal = normalize(worldNormal);
				o.worldNormal = worldNormal;

				float3 worldLight = UnityWorldSpaceLightDir(worldPos);
				worldLight = normalize(worldLight);

				float NDotL = dot(worldNormal, worldLight);
				NDotL = NDotL * 0.5 + 0.5;
				o.halfLambert = NDotL; //Color1其实是halfLambert

				//下面这段代码什么意思?
				float4 u_xlat0 = v.vertex;
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				float4 u_xlat2;
				u_xlat2.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;

				int iUsingDitherAlpha = asint(_UsingDitherAlpha);
				o.texcoord3 = (iUsingDitherAlpha != 0) ? float4(u_xlat0.xyw,_DitherAlpha) : float4(0,0,0,0);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//测试用
				float3 white = float3(1,1,1);
				float3 red = float3(1,0,0);
				float3 green = float3(0,1,0);
				float3 blue = float3(0,0,1);
				float3 black = float3(0,0,0);

				float3 lightMap = tex2D(_LightMapTex, i.uv).xyz;
				float4 albedo = tex2D(_MainTex, i.uv);
				float3 mainColor = albedo.rgb;

				float bloomMask = 0;
				int iUsingBloomMask = asint(_UsingBloomMask);
				if(iUsingBloomMask != 0 )
				{
					float bm = tex2D(_BloomMaskTex, i.uvBloom).x;
					bloomMask = bm * albedo.a;
				}

				int iUsingDitherAlpha = asint(_UsingDitherAlpha);
				//TODO 先不算DitherAlpha

				

				float r = i.color0.r;
				//这里的r有问题;所以直接赋值为1
				//r = 0.5;
				r = 1;
				float g = lightMap.g;

				float rgProduct = r * g;//用于diffuse颜色三层的选择

				float rgFix1 = rgProduct * 1.20000005 + (-0.100000001);
				float rgFix2 = rgProduct * 1.25 + (-0.125);
				float rgProductFix = (rgProduct <= 0.5) ? rgFix2: rgFix1;

				float rg_NDotL = rgProduct + i.halfLambert;
				float rgFix_NDotL = rgProductFix + i.halfLambert;

				float half_rg_NDotL = rg_NDotL * 0.5;
				float half_rgFix_NDotL = rgFix_NDotL * 0.5;

				float3 firstShadowColor = mainColor * _FirstShadowMultColor.xyz;
				float3 secondShadowColor = mainColor * _SecondShadowMultColor.xyz;

				float3 shadowColor = half_rg_NDotL >= _SecondShadow ? firstShadowColor : secondShadowColor;
				//float3 shadowColor = half_rg_NDotL >= _SecondShadow ? green: black;

				
				float3 otherColor = half_rgFix_NDotL  >= _LightArea ? mainColor : firstShadowColor;
				//float3 otherColor = half_rgFix_NDotL >= _LightArea ? white : red;


				float3 diffuseColor = rgProduct >= 0.090000033? otherColor: shadowColor;
				//float3 diffuseColor = rgProduct >= 0.090000033? otherColor: blue;


				float3 worldNormal = normalize(i.worldNormal);
				float3 worldView = normalize(UnityWorldSpaceViewDir(i.worldPos));
				float3 worldLight = normalize(UnityWorldSpaceLightDir(i.worldPos));
				float3 worldHalf = normalize(worldView + worldLight);
				float NDotH = dot(worldNormal, worldHalf);
				NDotH = max(NDotH, 0);
				

				float blinnSpec = pow(NDotH, _Shiniess);
				float3 spec = _LightSpecColor * _SpecMulti * lightMap.r;
				float3 specColor = (blinnSpec + lightMap.b) <= 1 ? float3(0,0,0): spec;

				float3 finalColor = diffuseColor + specColor;
				finalColor = finalColor * _Color.rgb;
				float finalAlpha = _Color.a * _BloomFactor;

				float4 final = float4(finalColor, finalAlpha);


				float3 emiColor = mainColor * _Emission;
				emiColor = emiColor * _EmissionColor.rgb - finalColor.rgb;
				float emiAlpha = _EmissionBloomFactor - finalAlpha;

				float4 emi = float4(emiColor, emiAlpha);
				
				float4 target = bloomMask * emi + final;

				return target;
			}
			ENDCG
		}
	}
}
