From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 29 Jun 2015 16:13:05 +0200
Subject: [PATCH v4] ARM: dts: mt8173: support arm64 cpuidle-dt
In-Reply-To: <5590FF5C.10408@linaro.org>
References: <1433402017-7711-1-git-send-email-howard.chen@linaro.org>
 <5590FF5C.10408@linaro.org>
Message-ID: <CABuKBe+VF+SEm6UfjQ6OTCz1mw6mT8ut3nbm_bj7UXsdTtirJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-29 10:18 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 06/04/2015 09:13 AM, Howard Chen wrote:
>>
>> This patch adds an idle-states node to describe the mt8173 idle states and
>> also adds references to the idle-states node in all CPU nodes.
>>
>> Changes:
>>
>> v4:
>> - Refine the property ordering.
>>
>> v3:
>> - Add the local-timer-stop property.
>>
>> v2:
>> - Remove the change to the PSCI version.
>> - Remove the cluster idle state.
>> - Fine tune the latency properties of the idle state.
>>
>> Signed-off-by: Howard Chen <howard.chen@linaro.org>
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
>
> A bit late but ...
>
> Sounds good.
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I deleted the change log part and applied it to v4.2-next/arm64

Thanks,
Matthias
