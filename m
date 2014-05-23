From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 May 2014 04:48:32 +0900
Subject: [PATCH v2 0/3] Exynos multi-platform support
In-Reply-To: <201405232117.12348.arnd@arndb.de>
References: <1400858369-14357-1-git-send-email-sachin.kamat@linaro.org>
 <201405232117.12348.arnd@arndb.de>
Message-ID: <537FA610.6050609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/14 04:17, Arnd Bergmann wrote:
> On Friday 23 May 2014, Sachin Kamat wrote:
>> The patches in this series were earlier sent as part of other
>> series. Now that the other patches have been merged, re-sending
>> these after rebasing them on linux-next (20140523).
>> Tested on Exynos4210, 4412, 5250 and 5420 based boards.
>>
>> A particular change in this series is the removal of single platform
>> support for Exynos as suggested by Arnd and Olof (patch 2/3). With
>> this change certain features (drivers) which are not yet multi-platform
>> aware like cpufreq, devfreq and DRM based gscaler will not be available
>> now.
>
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>

Yes, it's time to move on exynos multiplatform and we can't wait for 
more perfect something. Anyway if any problems, let's fix them after 
this. Will apply this whole series.

Thanks,
Kukjin
