using Liminal.Core.Fader;
using Liminal.SDK.Core;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class App : MonoBehaviour
{
    public PlayableDirector Director;
    public float EndingTime = 196;

    private IEnumerator Start()
    {
        yield return UpdateLoop();
    }

    private IEnumerator UpdateLoop()
    {
        yield return new WaitUntil(() => Director.time >= EndingTime);

        ScreenFader.Instance.FadeToBlack(3);
        yield return ScreenFader.Instance.WaitUntilFadeComplete();

        End();
    }

    public void End()
    {
        ExperienceApp.End();
    }
}
