#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec2 _texelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0.xy = in_TEXCOORD0.xy + _texelSize.xy;
    u_xlat16_0.zw = _texelSize.xy * vec2(1.0, -1.0) + in_TEXCOORD0.xy;
    phase0_Output0_1 = u_xlat16_0;
    u_xlat16_0.xy = in_TEXCOORD0.xy + (-_texelSize.xy);
    u_xlat16_0.zw = _texelSize.xy * vec2(-1.0, 1.0) + in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat16_0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
    return;
}