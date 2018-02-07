#version 300 es

precision highp float;
precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionBloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
int u_xlati3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat8;
mediump float u_xlat16_8;
ivec3 u_xlati8;
mediump vec3 u_xlat16_10;
bvec2 u_xlatb14;
float u_xlat20;
mediump float u_xlat16_22;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat10_0.w * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat10_0.w;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb14.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb14.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_2.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.x = u_xlat10_2.y * vs_COLOR0.x;
    u_xlat20 = vs_COLOR0.x * u_xlat10_2.y + 0.909999967;
    u_xlat20 = floor(u_xlat20);
    u_xlat8.z = max(u_xlat20, 0.0);
    u_xlat16_10.x = vs_COLOR0.x * u_xlat10_2.y + vs_COLOR1;
    u_xlat16_10.x = u_xlat16_10.x * 0.5 + (-_SecondShadow);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati3 = int(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat10_0.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_10.xyz = (int(u_xlati3) != 0) ? u_xlat16_5.xyz : u_xlat16_10.xyz;
    u_xlat8.x = (-vs_COLOR0.x) * u_xlat10_2.y + 1.5;
    u_xlat8.x = floor(u_xlat8.x);
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlati8.xz = ivec2(u_xlat8.xz);
    u_xlat3.xy = u_xlat16_4.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_4.x = (u_xlati8.x != 0) ? u_xlat3.y : u_xlat3.x;
    u_xlat16_4.x = u_xlat16_4.x + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati8.x = int(u_xlat16_4.x);
    u_xlat16_5.xyz = (u_xlati8.x != 0) ? u_xlat10_0.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (u_xlati8.z != 0) ? u_xlat16_5.xyz : u_xlat16_10.xyz;
    u_xlat16_22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_5.xyz = vec3(u_xlat16_22) * vs_TEXCOORD1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_22 = dot(u_xlat16_5.xyz, u_xlat3.xyz);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlat16_22 = log2(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * _Shininess;
    u_xlat16_22 = exp2(u_xlat16_22);
    u_xlat16_8 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_8 = (-u_xlat16_22) + u_xlat16_8;
    u_xlat8.x = u_xlat16_8 + 1.0;
    u_xlat8.x = floor(u_xlat8.x);
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlati8.x = int(u_xlat8.x);
    u_xlat16_5.xyz = vec3(_SpecMulti * _LightSpecColor.xxyz.y, _SpecMulti * _LightSpecColor.xxyz.z, _SpecMulti * float(_LightSpecColor.z));
    u_xlat16_5.xyz = u_xlat10_2.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (u_xlati8.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_2.w = _Color.w * _BloomFactor;
    u_xlat16_4.xyz = u_xlat10_0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_0.xyz = u_xlat16_4.xyz * _EmissionColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_0.w = (-_BloomFactor) * _Color.w + _EmissionBloomFactor;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat16_2;
    return;
}