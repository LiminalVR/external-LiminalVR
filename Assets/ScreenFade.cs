using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Liminal.Core.Fader;

public class ScreenFade : MonoBehaviour
{
    public void OnEnable()
    {
        ScreenFader.Instance.FadeToBlack(2f);
    }

    public void OnDisable()
    {
        ScreenFader.Instance.FadeToClear(2f);
    }
}
