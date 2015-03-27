From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Mar 2015 22:46:57 +0530
Subject: [PATCH] clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for
 defining features
In-Reply-To: <20150227074601.GO7789@pengutronix.de>
References: <3fac202ead48b50c0967c62eae92fe9786fd24a1.1425015704.git.viresh.kumar@linaro.org>
 <20150227074601.GO7789@pengutronix.de>
Message-ID: <CAKohpokxaGDYv8B-_UiFU+rmbbMerRZLJyJ9=-YHF2KurX6k8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 13:16, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Viresh,
>
> On Fri, Feb 27, 2015 at 11:12:33AM +0530, Viresh Kumar wrote:
>> We have used CLOCK_EVT_MODE_PERIODIC instead of CLOCK_EVT_FEAT_PERIODIC while
>> defining features. Fix it.
>>
>> Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Makes sense, thanks for catching.
>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

@Daniel: Have you applied this one ?
