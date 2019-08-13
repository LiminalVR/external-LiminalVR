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
    public float FadeRate;

    private IEnumerator Start()
    {
        yield return UpdateLoop();
    }

    private IEnumerator UpdateLoop()
    {
        yield return new WaitUntil(() => Director.time >= EndingTime);

        var fadeTime = 3f;
        ScreenFader.Instance.FadeToBlack(fadeTime);

        while(AudioListener.volume > 0)
        {
            AudioListener.volume -= Time.deltaTime * FadeRate;
            yield return new WaitForEndOfFrame();
        }

        var elapsedTime = 1f/FadeRate;

        while (elapsedTime < fadeTime)
        {
            elapsedTime += Time.deltaTime;
            yield return new WaitForEndOfFrame();
        }

        End();
    }

    public void End()
    {
        ExperienceApp.End();
    }
}
