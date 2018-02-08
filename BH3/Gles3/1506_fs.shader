#version 300 es

precision highp float;
precision highp int;
uniform 	float _Threshhold;
uniform 	float _Scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat0.xyz + (-vec3(_Threshhold));
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_Scaler, _Scaler, _Scaler));
    u_xlat2.xyz = u_xlat0.www * u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    SV_Target0 = u_xlat0;
    return;
}