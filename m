From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 13 Nov 2013 11:29:30 +0100
Subject: [PATCH 5/7] clocksource/cadence_ttc: Overhaul clocksource
 frequency adjustment
In-Reply-To: <CAKohpo=KaM97jJ2MnZxSeBz=Mf9cSmzk_EFQTL=EVPPvSH=Wag@mail.gmail.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>	<1383945677-29674-6-git-send-email-soren.brinkmann@xilinx.com>	<52827B11.5040308@linaro.org>
 <CAKohpo=KaM97jJ2MnZxSeBz=Mf9cSmzk_EFQTL=EVPPvSH=Wag@mail.gmail.com>
Message-ID: <5283548A.8050903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 09:03 AM, Viresh Kumar wrote:
> On 13 November 2013 00:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> Hmm, it could be interesting if Viresh can give its opinion on this patch
>> [cc'ed].
>
> I am not sure if I understood the problem completely, but if this is about
> not allowing frequency transitions from cpufreq when we have started to
> suspend our system, then you must have a look at this thread:
>
> https://lkml.org/lkml/2013/10/24/369

Thanks Viresh for the pointer.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
