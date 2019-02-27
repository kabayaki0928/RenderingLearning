Shader "katou_s/Specular"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		LOD 200
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vertexPhong
			#pragma fragment fragmentPhong

			#include "Lighting.cginc"

			struct PhongAppToVertex
			{
				float4 vertex : POSITION;
				float4 normal : NORMAL;
			};

			struct PhongVertexToFlagment
			{
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
			};

			PhongVertexToFlagment vertexPhong ( PhongAppToVertex v )
			{
				PhongVertexToFlagment o;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = v.normal;

				return o;
			}

			float4 fragmentPhong( PhongVertexToFlagment v2f ) : SV_Target
			{
				//float4 result;
				//
				//float3 l = normalize(_WorldSpaceLightPos0.xyz - v2f.vertex.xyz);
				//float3 v = normalize(_WorldSpaceCameraPos.xyz - v2f.vertex.xyz);
				//float3 h = normalize(l + v);
				//float3 n = normalize(v2f.normal.xyz);
				//float i = pow(saturate(dot(h, n)), 10);
				//
				//return float4(i * _LightColor0.xyz, 1.0);

				float3 l = normalize(_WorldSpaceLightPos0.xyz - v2f.vertex.xyz);
				float3 n = normalize(v2f.vertex.xyz);
				float3 r = 2.0 * n * dot(n, l) - l;
				float3 v = normalize(_WorldSpaceCameraPos.xyz - v2f.vertex.xyz);
				float i = pow(saturate(dot(r, v)), 1);

				return float4(i * _LightColor0.xyz, 1.0);


			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
