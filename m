From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 16:25:30 +0900
Subject: [PATCH 0/3] ARM: SAMSUNG: register the second instance of PL330
	DMAC
In-Reply-To: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
References: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <000d01cc6d2f$52bc1490$f8343db0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

alim akhtar wrote:
> 
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Two instance of platform data is provided for PL330 but only one PL330
DMAC
> instance is registered with amba_device.
> These patch sets registers the second instance with amba_device.
> 
> These patches are based on kgene's tree next/topic-dma-pl330 branch.
>
http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;;a=summary
> 
> Alim Akhtar (3):
>   ARM: EXYNOS4: register the second instance of pl330 DMAC
>   ARM: S5PV210: register the second instance of pl330 DMAC
>   ARM: S5PC100: register the second instance of pl330 DMAC
> 
>  arch/arm/mach-exynos4/dma.c |    1 +
>  arch/arm/mach-s5pc100/dma.c |    1 +
>  arch/arm/mach-s5pv210/dma.c |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> 
> --
> 1.7.2.3

Looks ok to me, will apply whole series.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
