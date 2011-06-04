From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Jun 2011 17:49:47 -0700
Subject: [PATCH v3 0/3] Fixes for breakage resulting from syscore_ops
	patch on s3c24xx
In-Reply-To: <201106021254.57644.heiko@sntech.de>
References: <201106021254.57644.heiko@sntech.de>
Message-ID: <4DE9812B.6010005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/11 03:54, Heiko St?bner wrote:
> The syscore_ops patch from Rafael J. Wysocki introduced some small
> glitches for the S3C24XX cpus resulting in compile errors.
>
> Changes since v1: add missing Signed-off-by lines
> Changes since v2: fix mangled tabs
>
> Heiko Stuebner (3):
>    Fix missing struct for s3c2410_dma_chan in s3c2410_dma_suspend_chan
>    Move s3c24xx_irq_syscore_ops to plat-s3c24xx/irq.c
>    remove the now empty mach-s3c2410/irq.c
>
>   arch/arm/mach-s3c2410/Makefile |    1 -
>   arch/arm/mach-s3c2410/irq.c    |   34 ----------------------------------
>   arch/arm/plat-s3c24xx/dma.c    |    2 +-
>   arch/arm/plat-s3c24xx/irq.c    |    6 ++++++
>   4 files changed, 7 insertions(+), 36 deletions(-)
>   delete mode 100644 arch/arm/mach-s3c2410/irq.c

Looks OK, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
