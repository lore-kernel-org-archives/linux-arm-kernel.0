From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Nov 2012 10:51:40 +0900
Subject: [GIT PULL] Samsung fixes-3 for v3.7
In-Reply-To: <50AB913D.2020604@samsung.com>
References: <50AB913D.2020604@samsung.com>
Message-ID: <10e701cdc91d$151bf240$3f53d6c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Hi Arnd, Olof
> 
> Here is Samsung fixes for v3.7 and it is for fixing of mdma1 address for
> exynos4210 rev0 SoC.
> 
> Please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.7-samsung-fixes-3
> 

Probably, missed?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> The following changes since commit
> f4a75d2eb7b1e2206094b901be09adb31ba63681:
> 
>    Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
> 
> are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.7-samsung-fixes-3
> 
> Bartlomiej Zolnierkiewicz (1):
>        ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of Exynos4210 SOC
> 
>   arch/arm/mach-exynos/dma.c              |    3 +++
>   arch/arm/mach-exynos/include/mach/map.h |    1 +
>   2 files changed, 4 insertions(+), 0 deletions(-)
