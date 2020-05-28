// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify_Hills"
{
	Properties
	{
		_Grid("Grid", 2D) = "white" {}
		_NoiseMask("NoiseMask", 2D) = "white" {}
		_Height("Height", Float) = 0
		_NoiseMapMoveSpeed("NoiseMapMoveSpeed", Vector) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (1,1,0,0)
		_GridMoveSpeed("GridMoveSpeed", Vector) = (0,0,0,0)
		[HDR]_GridColor("GridColor", Color) = (0,0,0,0)
		_NoiseScale("NoiseScale", Float) = 1
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
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float2 _NoiseMapMoveSpeed;
		uniform float2 _Vector0;
		uniform float _NoiseScale;
		uniform sampler2D _NoiseMask;
		uniform float4 _NoiseMask_ST;
		uniform float _Height;
		uniform sampler2D _Grid;
		uniform float2 _GridMoveSpeed;
		uniform float4 _Grid_ST;
		uniform float4 _GridColor;


		//https://www.shadertoy.com/view/XdXGW8
		float2 GradientNoiseDir( float2 x )
		{
			const float2 k = float2( 0.3183099, 0.3678794 );
			x = x * k + k.yx;
			return -1.0 + 2.0 * frac( 16.0 * k * frac( x.x * x.y * ( x.x + x.y ) ) );
		}
		
		float GradientNoise( float2 UV, float Scale )
		{
			float2 p = UV * Scale;
			float2 i = floor( p );
			float2 f = frac( p );
			float2 u = f * f * ( 3.0 - 2.0 * f );
			return lerp( lerp( dot( GradientNoiseDir( i + float2( 0.0, 0.0 ) ), f - float2( 0.0, 0.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 0.0 ) ), f - float2( 1.0, 0.0 ) ), u.x ),
					lerp( dot( GradientNoiseDir( i + float2( 0.0, 1.0 ) ), f - float2( 0.0, 1.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 1.0 ) ), f - float2( 1.0, 1.0 ) ), u.x ), u.y );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 color9 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 uv_TexCoord48 = v.texcoord.xy * _Vector0;
			float2 panner51 = ( 1.0 * _Time.y * _NoiseMapMoveSpeed + uv_TexCoord48);
			float gradientNoise46 = GradientNoise(panner51,_NoiseScale);
			gradientNoise46 = gradientNoise46*0.5 + 0.5;
			float4 temp_cast_0 = (gradientNoise46).xxxx;
			float2 uv_NoiseMask = v.texcoord * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
			float4 lerpResult8 = lerp( color9 , temp_cast_0 , tex2Dlod( _NoiseMask, float4( uv_NoiseMask, 0, 0.0) ));
			v.vertex.xyz += ( lerpResult8 * _Height ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv0_Grid = i.uv_texcoord * _Grid_ST.xy + _Grid_ST.zw;
			float2 panner40 = ( 1.0 * _Time.y * _GridMoveSpeed + uv0_Grid);
			o.Emission = ( tex2D( _Grid, panner40 ) * _GridColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
166.6667;908;1500;786;2784.621;515.8152;1.256539;True;True
Node;AmplifyShaderEditor.Vector2Node;49;-2239.673,-276.3365;Float;False;Property;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;34;-2310.512,184.4747;Float;False;Property;_NoiseMapMoveSpeed;NoiseMapMoveSpeed;4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-1898.82,-326.7688;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-1796.417,-162.0769;Float;False;Property;_NoiseScale;NoiseScale;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;51;-1827.138,-106.1834;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-2125.611,328.4883;Float;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;43;-2154.073,502.4762;Float;False;Property;_GridMoveSpeed;GridMoveSpeed;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;40;-1858.021,458.1206;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;31;-950.3433,-272.2016;Float;True;Property;_NoiseMask;NoiseMask;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-1583.953,-4.596077;Float;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;46;-1524.087,-306.6236;Float;True;Gradient;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;8.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-340.9061,536.0244;Float;False;Property;_Height;Height;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;8;-510.8874,167.3095;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;45;-1040.46,813.1873;Float;False;Property;_GridColor;GridColor;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;-1593.999,555.6423;Float;True;Property;_Grid;Grid;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-939.5923,602.757;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-112.3306,380.8094;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2283.512,40.4747;Float;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-1609.11,201.2827;Float;True;Property;_NoiseMap;NoiseMap;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;32;-1920.102,157.7748;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;252.2,13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Amplify_Hills;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;49;0
WireConnection;51;0;48;0
WireConnection;51;2;34;0
WireConnection;40;0;41;0
WireConnection;40;2;43;0
WireConnection;46;0;51;0
WireConnection;46;1;50;0
WireConnection;8;0;9;0
WireConnection;8;1;46;0
WireConnection;8;2;31;0
WireConnection;42;1;40;0
WireConnection;44;0;42;0
WireConnection;44;1;45;0
WireConnection;27;0;8;0
WireConnection;27;1;28;0
WireConnection;10;1;32;0
WireConnection;32;0;37;0
WireConnection;32;2;34;0
WireConnection;0;2;44;0
WireConnection;0;11;27;0
ASEEND*/
//CHKSM=70D91D38EB4E84055C0C42E6C4B6417B6F64D262