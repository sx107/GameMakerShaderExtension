
struct PSInput {
	float4 position : SV_POSITION;
	float2 uv: TEXCOORD;
	float color: COLOR;
	float3 worldPosition: POSITION1;
	float3 terrainNormal: NORMAL1;
};

struct PSOutput {
	float4 color: SV_TARGET;
};



PSOutput main (PSInput input) {
	
	PSOutput output;
	output.color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	
	return output;
}