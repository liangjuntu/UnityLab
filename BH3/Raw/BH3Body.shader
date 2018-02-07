Shader "BH3/BH3Body"
{
	Properties
	{
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
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 color0: COLOR;
				float color1: COLOR1;
				float3 worldNormal: TEXCOORD1;
				float3 worldPos : TEXCOORD2;
			};

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
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//o.uv.y = 1 - o.uv.y;
				o.color0 = v.color;
				//

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldPos = worldPos;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				worldNormal = normalize(worldNormal);
				o.worldNormal = worldNormal;

				float3 worldLight = UnityWorldSpaceLightDir(worldPos);
				worldLight = normalize(worldLight);

				float NDotL = dot(worldNormal, worldLight);
				NDotL = NDotL * 0.5 + 0.5;
				o.color1 = NDotL; //Color2其实是halfLambert

				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 lightMap = tex2D(_LightMapTex, i.uv).xyz;
				float3 albedo = tex2D(_MainTex, i.uv).xyz;

				float3 white = float3(1,1,1);
				float3 red = float3(1,0,0);
				float3 green = float3(0,1,0);
				float3 blue = float3(0,0,1);
				float3 black = float3(0,0,0);

				float r = i.color0.r;
				//这里的r有问题;所以直接赋值为1
				//r = 0.5;
				r = 0.5;
				float g = lightMap.g;

				float rgProduct = r * g;//用于diffuse颜色三层的选择

				float3 u_xlat16_2 = float3(rgProduct,0.0,0.0);
				
				float u_xlat15 = floor(rgProduct + 0.909999967);
				u_xlat15 = max(u_xlat15, 0.0);

				float3 u_xlat5 = float3(0,0,u_xlat15);


				float3 firstShadowColor = albedo.xyz * _FirstShadowMultColor.xyz;
				float3 secondShadowColor = albedo.xyz * _SecondShadowMultColor.xyz;

				float rg_NDotL = rgProduct + i.color1;

				float3 shadowColor = rg_NDotL * 0.5 >= _SecondShadow ? firstShadowColor : secondShadowColor;
				//float3 shadowColor = rg_NDotL * 0.5 >= _SecondShadow ? green: black;

				u_xlat5.x = max(floor(-rgProduct + 1.5),0);
				u_xlat5.xz = asint(u_xlat5.xz);
				float3 u_xlat4 = 0;
				u_xlat4.xy = u_xlat16_2.xx * float2(1.20000005, 1.25) + float2(-0.100000001, -0.125);
				float rgProductFix =  (asint(u_xlat5.x) != 0) ? u_xlat4.y : u_xlat4.x;

				float rgFix_NDotL = rgProductFix + i.color1;
				float3 otherColor = rgFix_NDotL * 0.5 >= _LightArea ? albedo : firstShadowColor;
				//float3 otherColor = rgFix_NDotL * 0.5 >= _LightArea ? white : red;


				


				float3 diffuseColor = rgProduct >= 0.090000033? otherColor: shadowColor;
				//float3 diffuseColor = rgProduct >= 0.090000033? otherColor: blue;


				float3 worldNormal = normalize(i.worldNormal);
				float3 worldView = normalize(UnityWorldSpaceViewDir(i.worldPos));
				float3 worldLight = normalize(UnityWorldSpaceLightDir(i.worldPos));
				float3 worldHalf = normalize(worldView + worldLight);
				float NDotH = dot(worldNormal, worldHalf);
				NDotH = max(NDotH, 0);
				float u_xlat16_17 = log2(NDotH);
				u_xlat16_17 = u_xlat16_17 * _Shiniess;
				u_xlat16_17 = exp2(u_xlat16_17);

				float blinnSpec = u_xlat16_17;
				float3 spec = _LightSpecColor * _SpecMulti * lightMap.r;
				float3 specColor = (blinnSpec + lightMap.b) > 1 ? spec: float3(0,0,0);

				float3 final = diffuseColor + specColor;
				final = final * _Color.rgb;

				float4 col = float4(final,1);
				//col = float4(albedo.xyz,1);
				//col = float4(firstShadowColor,1);
				//col = float4(secondShadowColor,1);
				//col = float4(_FirstShadowMultColor.xyz,1);
				//col = float4(_SecondShadowMultColor.xyz,1);
				//col = float4(r,r,r,1);
				//col = float4(g,g,g,1);
				//col = float4(rgProduct,rgProduct,rgProduct,1);
				//col = float4(rgProductFix,rgProductFix,rgProductFix,1);
				//col = float4(rgProductFix*0.5,rgProductFix*0.5,rgProductFix*0.5,1);
				//col = float4(i.color1,i.color1,i.color1,1);
				//col = float4(otherColor,1);
				//col = float4(shadowColor,1);
				//col = float4(0.090000033,0.090000033,0.090000033,1);
				//col = float4(lightMap.r, lightMap.r, lightMap.r, 1);
				//col = float4(lightMap.b, lightMap.b, lightMap.b, 1);
				//col = float4(_LightSpecColor.rgb,1);
				//col = float4(spec,1);
				//col = float4(blinnSpec,blinnSpec,blinnSpec,1);
				//col = float4(_Color.rgb,1);
				//col = float4(diffuseColor,1);
				//col = float4(specColor,1);

				/*
				float3 worldNormal = normalize(i.worldNormal);
				float3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
				fixed diff =  dot(worldNormal, worldLightDir); 
				diff = (diff * 0.5 + 0.5);
				col = float4(diff,diff,diff,1);
				*/

				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				col.a = _BloomFactor;
				return col;
			}
			ENDCG
		}
	}
}
