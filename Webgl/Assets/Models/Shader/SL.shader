// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shader/SL"
{
	Properties
	{
		_TextureSample0("主纹理", 2D) = "white" {}
		_Float0("速度", Float) = 0.5
		_Vector0("方向", Vector) = (0.5,0,0,0)
		_Float1("扰乱速度", Float) = 0.5
		_Vector1("扰乱方向", Vector) = (-0.5,-0.5,0,0)
		_TextureSample1("扰乱纹理", 2D) = "white" {}
		_Float2("主纹理强度", Float) = 1.24
		_Float3("扰动强度", Float) = 0.36
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
		uniform float2 _Vector0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _TextureSample1;
		uniform float _Float1;
		uniform float2 _Vector1;
		uniform float4 _TextureSample1_ST;
		uniform float _Float3;
		uniform float _Float2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 panner2 = ( ( _Float0 * _Time.y ) * _Vector0 + uv_TextureSample0);
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 panner15 = ( ( _Float1 * _Time.y ) * _Vector1 + uv_TextureSample1);
			o.Emission = ( tex2D( _TextureSample0, ( float4( panner2, 0.0 , 0.0 ) + ( tex2D( _TextureSample1, panner15 ) * _Float3 ) ).rg ) * _Float2 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;0;1536;803;2995.024;702.4554;1.69704;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;11;-1991.06,464.8556;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1994.06,369.8554;Inherit;False;Property;_Float1;扰乱速度;3;0;Create;False;0;0;0;False;0;False;0.5;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;14;-1856.06,233.8555;Inherit;False;Property;_Vector1;扰乱方向;4;0;Create;False;0;0;0;False;0;False;-0.5,-0.5;-0.5,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1920.06,108.8555;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1762.06,405.8555;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1566.158,-18.29463;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1569.158,-113.2946;Inherit;False;Property;_Float0;速度;1;0;Create;False;0;0;0;False;0;False;0.5;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;15;-1543.06,182.8555;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1120.243,380.2746;Inherit;False;Property;_Float3;扰动强度;7;0;Create;False;0;0;0;False;0;False;0.36;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-1431.158,-249.2946;Inherit;False;Property;_Vector0;方向;2;0;Create;False;0;0;0;False;0;False;0.5,0;0.5,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1495.158,-374.2947;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1337.158,-77.29462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1232.716,123.3473;Inherit;True;Property;_TextureSample1;扰乱纹理;5;0;Create;False;0;0;0;False;0;False;-1;60d6ad3bf3e6d1f4a92169263b2d4fb9;60d6ad3bf3e6d1f4a92169263b2d4fb9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;2;-1118.158,-300.2947;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-857.2429,210.2746;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-701.2473,-203.349;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-337.2025,-54.09087;Inherit;False;Property;_Float2;主纹理强度;6;0;Create;False;0;0;0;False;0;False;1.24;1.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-423.1518,-293.0174;Inherit;True;Property;_TextureSample0;主纹理;0;0;Create;False;0;0;0;False;0;False;-1;4813a3f045b72f3488c62f34c0b5ac37;4813a3f045b72f3488c62f34c0b5ac37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-84.98113,-137.7843;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;227,-192;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Shader/SL;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;13;0
WireConnection;12;1;11;0
WireConnection;15;0;10;0
WireConnection;15;2;14;0
WireConnection;15;1;12;0
WireConnection;7;0;6;0
WireConnection;7;1;5;0
WireConnection;8;1;15;0
WireConnection;2;0;3;0
WireConnection;2;2;4;0
WireConnection;2;1;7;0
WireConnection;22;0;8;0
WireConnection;22;1;23;0
WireConnection;9;0;2;0
WireConnection;9;1;22;0
WireConnection;1;1;9;0
WireConnection;16;0;1;0
WireConnection;16;1;17;0
WireConnection;0;2;16;0
ASEEND*/
//CHKSM=AE3865ABEB8B8BE212A1290A3B2BAF94C1E0B5A1