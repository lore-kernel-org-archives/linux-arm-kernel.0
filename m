From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH 0/3] ARM: Samsung: use dma-pl330 device name for clock
In-Reply-To: <1313530266-14939-1-git-send-email-vz@mleia.com>
References: <1313530266-14939-1-git-send-email-vz@mleia.com>
Message-ID: <000701cc5e30$3a4e1a60$aeea4f20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir Zapolskiy wrote:
> 
> This changeset replaces s3c-pl330.x clock device names with
> dma-pl330.x, otherwise there won't be a correspondence between clock
> device name and amba device name, thus clocks can't be enabled.
> 
> Fixes runtime errors on clk_get() from drivers/dma/pl330.c:
>   dma-pl330 dma-pl330.0: Cannot get operation clock.
>   dma-pl330: probe of dma-pl330.0 failed with error -22
> 
> The changes are based on linux-samsung/next/topic-dma-pl330 branch.
> 
> Vladimir Zapolskiy (3):
>   ARM: EXYNOS4: use dma-pl330 device name for clock
>   ARM: S5PC100: use dma-pl330 device name for clock
>   ARM: S5PV210: use dma-pl330 device name for clock
> 
>  arch/arm/mach-exynos4/clock.c |    4 ++--
>  arch/arm/mach-s5pc100/clock.c |    4 ++--
>  arch/arm/mach-s5pv210/clock.c |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> --
> 1.7.5.1

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
