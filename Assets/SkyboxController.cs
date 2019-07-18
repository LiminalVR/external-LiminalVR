using UnityEngine;

/// <summary>
/// The skybox controller should run in edit mode to improve the animation workflow
/// as we want the timeline to be able to make changes.
/// </summary>
[ExecuteInEditMode]
public class SkyboxController : MonoBehaviour
{
    public Material SkyboxMaterial;

    [Range(0,5)]
    public float SunDisk;
    public float SunSize;
    public float SunSizeConvergence;
    public float AtmosphereThickness;
    public Color SkyTint = Color.white;
    public Color Ground = Color.white;
    public float Exposure;



    private void Update()
    {
        SkyboxMaterial.SetFloat("_AtmosphereThickness", AtmosphereThickness);
        SkyboxMaterial.SetFloat("_SunDisk", SunDisk);
        SkyboxMaterial.SetFloat("_SunSize", SunSize);
        SkyboxMaterial.SetFloat("_SunSizeConvergence", SunSizeConvergence);
        SkyboxMaterial.SetFloat("_Exposure", Exposure);
    }
}
