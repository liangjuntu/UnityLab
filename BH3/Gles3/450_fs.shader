#version 300 es

precision highp float;
precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}