
struct LambertAppToVertex
{
	float4 vertex : POSITION;
	float4 normal : NORMAL;
};

struct LambertVertexToFlagment
{
    float4 vertex : SV_POSITION;
	float3 normal : NORMAL;
};

LambertVertexToFlagment vertexLambert (LambertAppToVertex v)
{
	LambertVertexToFlagment o;

	o.vertex = UnityObjectToClipPos(v.vertex);
	o.normal = v.normal;

	return o;
}

fixed4 fragmentLambert (LambertVertexToFlagment i) : SV_Target
{
	float3 lightPos = _WorldSpaceLightPos0;
	float result = dot( lightPos, i.normal );
	return float4( result, result, result, 1);
}
