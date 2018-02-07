#version 300 es

precision highp float;
precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
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
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
ivec3 u_xlati5;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb10;
float u_xlat15;
int u_xlati16;
mediump float u_xlat16_17;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat15 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat15 = floor(u_xlat15);
    u_xlat5.z = max(u_xlat15, 0.0);
    u_xlat16_7.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_SecondShadow);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati16 = int(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati16) != 0) ? u_xlat16_3.xyz : u_xlat16_7.xyz;

    
    u_xlat5.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat5.x = floor(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlati5.xz = ivec2(u_xlat5.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati5.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati5.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati5.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati5.z != 0) ? u_xlat16_3.xyz : u_xlat16_7.xyz;


    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat4.xyz = u_xlat5.xxx * u_xlat4.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    
    u_xlat16_5 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_5 = (-u_xlat16_17) + u_xlat16_5;
    u_xlat5.x = u_xlat16_5 + 1.0;
    u_xlat5.x = floor(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlati5.x = int(u_xlat5.x);
    u_xlat16_3.xyz = vec3(_SpecMulti * _LightSpecColor.xxyz.y, _SpecMulti * _LightSpecColor.xxyz.z, _SpecMulti * float(_LightSpecColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati5.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_lightProbToggle);
#else
    u_xlatb0 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}