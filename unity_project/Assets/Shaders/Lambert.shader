Shader "katou_s/Lambert"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		LOD 200
		Pass
		{
			CGPROGRAM

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0
			#pragma vertex vertexLambert
			#pragma fragment fragmentLambert

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "Core.cginc"


			ENDCG	
		}
	}
}
