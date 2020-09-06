Shader "katou_s/Speculer"
{
    Properties
	{
        _Shininess ("Shininess", Float) = 10	// 光の強さ
    }
    SubShader
	{
        Tags { "RenderType" = "Opaque" }
        LOD 200

        Pass {
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc" //Provides us with light data, camera information, etc

                uniform float4 _LightColor0; //From UnityCG
                uniform float _Shininess;

                struct appdata
                {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                };

                struct v2f
                {
                    float4 pos : POSITION;
                    float3 normal : NORMAL;
                    float4 posWorld : TEXCOORD1;
                };

                v2f vert(appdata v)
                {
                    v2f o;

                    o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                    o.normal = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);
                    o.pos = UnityObjectToClipPos(v.vertex);

                    return o;
                }

                fixed4 frag(v2f i) : COLOR
                {
					float3 L = normalize(_WorldSpaceLightPos0.xyz);
					float3 V = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
					float3 N = normalize(i.normal);	// 正規化したほうが頂点感が薄れた

					// Speculer
					// 公式
					// Rm = 2(dot(-L, N))*N + L
					// OpenGLの関数使う版
					//float3 specular = pow(max(0.0, dot(reflect(-L, N), V)), _Shininess);
					// 分解版
					float3 specular = pow(max(0.0, dot(-L - dot(-L, N) * 2 * N, V)), _Shininess);
					
					return fixed4(specular, 1.0);
				}
            ENDCG
        }
    }
}