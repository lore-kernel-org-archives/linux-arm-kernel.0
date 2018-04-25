From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 25 Apr 2018 17:16:15 +0100
Subject: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Message-ID: <d243f265-a567-e8c5-56b0-ebffe5104a55@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/04/18 16:04, Rob Herring wrote:
>> I can list the values for the HDMI playback use-case, but the list would
>> grow as we start adding wcd9335 codec support.
> If you don't have the values, then how does one validate a DT is correct?
> 
I can list all the sources and sinks wired on the board in next version.

> Honestly, a single property like this seems insufficient to describe
> audio routing.

This is how all the audio drivers do routing in DT, non DT is also 
pretty much inline with this.


--srini
> 
>>>> +
