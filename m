From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 13 Aug 2013 14:42:51 +0200
Subject: [GIT PULL]: CPUFreq: ARM Fixes for 3.12
In-Reply-To: <CAKohponyLTUn_Sonstw_oOLZ+S+x9e3UH0JaZbkLaQfX-9zmWw@mail.gmail.com>
References: <CAKohponyLTUn_Sonstw_oOLZ+S+x9e3UH0JaZbkLaQfX-9zmWw@mail.gmail.com>
Message-ID: <1439792.4fKVxGE7CH@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 12, 2013 12:03:39 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
> 
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/vireshk/linux.git cpufreq-fixes
> 
> for you to fetch changes up to 45e12086263a53f16b489fc7f4f8f6348a688661:
> 
>   cpufreq: fix EXYNOS drivers selection (2013-08-12 12:00:21 +0530)
> 
> ----------------------------------------------------------------
> Amit Daniel Kachhap (1):
>       cpufreq: exynos5440: Fix to skip when new frequency same as current
> 
> Bartlomiej Zolnierkiewicz (1):
>       cpufreq: fix EXYNOS drivers selection
> 
>  drivers/cpufreq/Kconfig.arm          | 36 ++++++++++++++++++++++++------------
>  drivers/cpufreq/exynos-cpufreq.c     |  1 -
>  drivers/cpufreq/exynos-cpufreq.h     | 21 +++++++++++++++++++++
>  drivers/cpufreq/exynos5440-cpufreq.c |  3 +++
>  4 files changed, 48 insertions(+), 13 deletions(-)

Pulled, thanks Viresh!

I assume this is 3.12 material?

Rafael
