From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Apr 2012 10:05:49 -0700
Subject: [PATCH 0/4] ARM: Exynos4: NURI and UniversalC210 fixes for
 v3.4-rc2
In-Reply-To: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
References: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F84686D.60606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> Hi Kukjin,
> 
Hi Marek,

> I've just checked the support for Samsung NURI and UniversalC210 boards
> in v3.4-rc1 and found some issues. The attached patches fixes the
> leftovers from missing s3c-sdhci driver changes, fixes division by
> zero caused by missing initial value for xusbxti clock and removes broken
> optional configuration entries for touch screen driver. It would be great
> if the attached patches will get merged to v3.4-rcX series.
> 
OK, looks good to me, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Best regards,
> Marek Szyprowski
> 
> 
> Patch summary:
> 
> Marek Szyprowski (4):
>    ARM: Exynos4: fix SDHCI support on NURI&  UniversalC210 boards
>    ARM: Exynos4: fix regulator name for NURI board
>    ARM: Exynos4: set fix xusbxti clock for NURI and Universal210 boards
>    ARM: Exynos4: Remove broken config values for touchscren for NURI
>      board
> 
>   arch/arm/mach-exynos/mach-nuri.c           |   51 +++-------------------------
>   arch/arm/mach-exynos/mach-universal_c210.c |    5 ++-
>   2 files changed, 9 insertions(+), 47 deletions(-)
> 
