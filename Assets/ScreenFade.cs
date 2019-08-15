using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Liminal.Core.Fader;

public class ScreenFade : MonoBehaviour
{
    public void OnEnable()
    {
        ScreenFader.Instance.FadeToBlack(5f);
    }

    public void OnDisable()
    {
        ScreenFader.Instance.FadeToClear(5f);
    }
}
