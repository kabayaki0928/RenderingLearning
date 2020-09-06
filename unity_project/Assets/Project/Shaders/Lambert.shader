Shader "katou_s/Lambert"
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
            Tags { "LightMode" = "ForwardBase" } //For the first light
			CGPROGRAM

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "Core.cginc"

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0
			#pragma vertex vertexLambert
			#pragma fragment fragmentLambert

			ENDCG	
		}
	}
}
