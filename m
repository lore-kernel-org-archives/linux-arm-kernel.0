From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 21:17:12 +0200
Subject: [PATCH v2 0/3] Exynos multi-platform support
In-Reply-To: <1400858369-14357-1-git-send-email-sachin.kamat@linaro.org>
References: <1400858369-14357-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <201405232117.12348.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Sachin Kamat wrote:
> The patches in this series were earlier sent as part of other
> series. Now that the other patches have been merged, re-sending
> these after rebasing them on linux-next (20140523).
> Tested on Exynos4210, 4412, 5250 and 5420 based boards.
> 
> A particular change in this series is the removal of single platform
> support for Exynos as suggested by Arnd and Olof (patch 2/3). With
> this change certain features (drivers) which are not yet multi-platform
> aware like cpufreq, devfreq and DRM based gscaler will not be available
> now.


Acked-by: Arnd Bergmann <arnd@arndb.de>
