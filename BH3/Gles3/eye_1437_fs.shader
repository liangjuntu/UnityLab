#version 300 es

precision highp float;
precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
ivec4 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb14;
mediump float u_xlat16_16;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0.x = int(u_xlat0.x);
            if((u_xlati0.x)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati1) != 0) ? u_xlat10_0.xy : u_xlat10_0.yx;
    u_xlat16_16 = (-u_xlat10_0.z) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + 1.0;
    u_xlat16_16 = floor(u_xlat16_16);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlati1 = int(u_xlat16_16);
    u_xlat16_3.z = (u_xlati1 != 0) ? u_xlat16_2.y : u_xlat10_0.z;
    u_xlat16_9.x = u_xlat10_0.z + (-u_xlat16_2.x);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati1 = int(u_xlat16_9.x);
    u_xlat16_2.x = (u_xlati1 != 0) ? u_xlat16_2.x : u_xlat10_0.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.z;
    u_xlat16_9.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlati1 = int(u_xlat16_9.x);
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.z;
    u_xlat16_9.xyz = (-u_xlat10_0.yzx) + u_xlat16_3.zzz;
    u_xlat16_24 = u_xlat16_2.x * 6.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_24);
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-u_xlat16_3.zzz);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_5.xyz = floor(u_xlat16_5.xyz);
    u_xlat16_23 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_18.xy = u_xlat16_2.zx + vec2(0.333333343, 0.666666687);
    u_xlati0.xyz = ivec3(u_xlat16_5.xyz);
    u_xlat16_2.xy = vec2((-u_xlat16_2.y) + u_xlat16_18.x, (-u_xlat16_2.z) + u_xlat16_18.y);
    u_xlat16_9.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_2.y;
    u_xlat16_2.x = (u_xlati0.y != 0) ? u_xlat16_9.x : u_xlat16_2.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_2.x : u_xlat16_23;
    u_xlat16_3.xy = (int(u_xlati1) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_2.xyz = u_xlat16_3.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_9.xyz = u_xlat16_3.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_9.x = fract(u_xlat16_9.x);
    u_xlat16_9.yz = u_xlat16_9.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.yz = min(max(u_xlat16_9.yz, 0.0), 1.0);
#else
    u_xlat16_9.yz = clamp(u_xlat16_9.yz, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = ceil(u_xlat16_2.x);
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyw = u_xlat16_2.xxx * u_xlat16_3.yzx + u_xlat16_9.yzx;
    u_xlat16_2.x = u_xlat16_1.w * 6.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_9.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.y = u_xlat16_1.y * u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_1.w * 6.0 + (-u_xlat16_2.x);
    u_xlat16_9.y = (-u_xlat16_1.x) * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = (-u_xlat16_9.x) + 1.0;
    u_xlat16_9.x = (-u_xlat16_1.x) * u_xlat16_9.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_9.yx;
    u_xlat16_9.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlati0.x = int(u_xlat16_9.x);
    u_xlat16_2 = u_xlat16_2.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2 = abs(u_xlat16_2) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati2 = ivec4(u_xlat16_2);
    u_xlat16_3.xz = (u_xlati2.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_3.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat16_3.xyz = (u_xlati2.y != 0) ? u_xlat16_3.xyz : u_xlat16_1.xzw;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.yzx;
    u_xlat16_3.xyz = (u_xlati0.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.zwx;
    u_xlat0.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5<_lightProbToggle);
#else
    u_xlatb6 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb6)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}