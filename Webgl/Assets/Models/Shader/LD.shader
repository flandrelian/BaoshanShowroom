// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shader/lLD"
{
	Properties
	{
		_TextureSample0("主纹理", 2D) = "white" {}
		_Float0("速度", Float) = 1
		_Color0("自发光颜色", Color) = (1,1,1,0)
		_Float1("自发光强度", Float) = 1.54
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Float0;
		uniform float4 _Color0;
		uniform float _Float1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float cos2 = cos( ( _Float0 * _Time.y ) );
			float sin2 = sin( ( _Float0 * _Time.y ) );
			float2 rotator2 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos2 , -sin2 , sin2 , cos2 )) + float2( 0.5,0.5 );
			o.Emission = ( tex2D( _TextureSample0, rotator2 ) * _Color0 * _Float1 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;0;1536;803;415.006;237.7888;1.522939;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;8;-480,96;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-448,0;Inherit;False;Property;_Float0;速度;1;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-240,48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-368,-336;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;5;-384,-192;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;2;-96,-192;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;469.5987,577.6588;Inherit;False;Property;_Float1;自发光强度;3;0;Create;False;0;0;0;False;0;False;1.54;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;276.2155,-202.3379;Inherit;True;Property;_TextureSample0;主纹理;0;0;Create;False;0;0;0;False;0;False;-1;7c782b340ab7d15479dc8e14dc8ead8c;7c782b340ab7d15479dc8e14dc8ead8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;440.787,398.3592;Inherit;False;Property;_Color0;自发光颜色;2;0;Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;950.3248,222.9838;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1464.119,186.8934;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Shader/lLD;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;2;2;9;0
WireConnection;1;1;2;0
WireConnection;17;0;1;0
WireConnection;17;1;20;0
WireConnection;17;2;18;0
WireConnection;0;2;17;0
ASEEND*/
//CHKSM=DC0E769530DA1F062A259DC7CAE5A2C8307F88B4