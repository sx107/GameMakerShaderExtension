float terrainSize;
float terrainCellSize;

struct VSInput {
	float3 position: POSITION;
	float3 normal: NORMAL;
	float2 uv: TEXCOORD0;
	float4 color: COLOR0;
};

struct VSOutput {
	float4 position : SV_POSITION;
	float2 uv: TEXCOORD;
	float color: COLOR;
};

Texture2D hmapTexture: register(t1);

VSOutput main(VSInput input) {
	float4 object_space_pos = float4(input.position, 1.0);
	float4 sample = hmapTexture[uint2(floor(terrainCellSize*input.position.x/terrainSize), floor(terrainCellSize*(terrainSize - input.position.y)/terrainSize))];
	object_space_pos.z = sample.r*30.0;
	
	
	VSOutput ret;
	ret.position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], object_space_pos);
	ret.color = input.color;
	ret.uv = input.uv;
	
	return ret;
}