using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TreeKiller : MonoBehaviour
{
    public float TargetEmissionRate;
    public List<ParticleSystem> Systems;
    private void OnEnable()
    {
        foreach (var system in Systems)
        {
            var emissionMod = system.emission;
            emissionMod.rateOverTime = TargetEmissionRate;
        }
    }
}
