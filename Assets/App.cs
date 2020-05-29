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
    public float FadeTime;

    private IEnumerator Start()
    {
        yield return UpdateLoop();
    }

    private IEnumerator UpdateLoop()
    {
        yield return new WaitUntil(() => Director.time >= EndingTime);

        var elapsedTime = 0f;
        var startingVolume = AudioListener.volume;
        ScreenFader.Instance.FadeToBlack(FadeTime);

        while (elapsedTime < FadeTime)
        {
            elapsedTime += Time.deltaTime;
            AudioListener.volume = Mathf.Lerp(startingVolume, 0f, elapsedTime / FadeTime);
            yield return new WaitForEndOfFrame();
        }

        End();
    }

    public void End()
    {
        ExperienceApp.End();
    }
}
