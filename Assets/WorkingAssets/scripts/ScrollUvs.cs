
using UnityEngine;

public class ScrollUvs : MonoBehaviour
{
    // Scroll main texture based on time

    public float scrollSpeedU = 0.5f;
	public float scrollSpeedV = 0.5f;
	
    Renderer rend;

    void Start()
    {
        rend = GetComponent<Renderer> ();
    }

    void Update()
    {
        float offsetU = Time.time * scrollSpeedU;
		float offsetV = Time.time * scrollSpeedV;
		
        rend.material.SetTextureOffset("_MainTex", new Vector2(offsetU, offsetV));
    }
}