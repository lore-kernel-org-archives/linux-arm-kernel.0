From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 06:33:25 +0900
Subject: [PATCH v2 0/3] Exynos multi-platform support
In-Reply-To: <537FB781.8050501@gmail.com>
References: <1400858369-14357-1-git-send-email-sachin.kamat@linaro.org>
 <201405232117.12348.arnd@arndb.de> <537FA610.6050609@samsung.com>
 <537FB781.8050501@gmail.com>
Message-ID: <538261A5.60107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/14 06:02, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi,

> On 23.05.2014 21:48, Kukjin Kim wrote:
>> On 05/24/14 04:17, Arnd Bergmann wrote:
>>> On Friday 23 May 2014, Sachin Kamat wrote:
>>>> The patches in this series were earlier sent as part of other
>>>> series. Now that the other patches have been merged, re-sending
>>>> these after rebasing them on linux-next (20140523).
>>>> Tested on Exynos4210, 4412, 5250 and 5420 based boards.
>>>>
>>>> A particular change in this series is the removal of single platform
>>>> support for Exynos as suggested by Arnd and Olof (patch 2/3). With
>>>> this change certain features (drivers) which are not yet multi-platform
>>>> aware like cpufreq, devfreq and DRM based gscaler will not be available
>>>> now.
>>>
>>>
>>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>>
>> Yes, it's time to move on exynos multiplatform and we can't wait for
>> more perfect something. Anyway if any problems, let's fix them after
>> this. Will apply this whole series.
>
> I have tested v1 of this series on Exynos4210-TRATS and
> Exynos4412-TRATS2 boards and they seemed to work fine with added two
> patches that are already on the ML:
>   - [PATCH v2] cpufreq: exynos: Fix driver compilation with
> ARCH_MULTIPLATFORM,

Hmm...yeah, Thomas re-submitted v5 but the patches are depending on 
others which are not yet decided to apply for 3.16...maybe it can be 
upstreamed in 3.17?...

>   - [PATCH] drm/exynos/fimd: allow multiplatform configuration.
>
> Not tested too extensively, but primary features (boot, display, USB
> gadget, cpufreq) seem to work at first glance with the above patches.
>
Thanks for your test and OK, I'll queue this with multiplatform patches.

- Kukjin
