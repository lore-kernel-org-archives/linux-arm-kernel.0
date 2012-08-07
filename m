From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 07 Aug 2012 19:37:40 +0900
Subject: [PATCH 0/2] ARM: S3C24XX: Fix compilation errors with 3.6-rc1
In-Reply-To: <201208051738.27728.heiko@sntech.de>
References: <201208051738.27728.heiko@sntech.de>
Message-ID: <099001cd7488$ab7c3270$02749750$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Small fallout from from the s3c64xx spi changes and from a dma change from
> last year, that only surfaced after a gcc update.
> 
> Heiko Stuebner (2):
>   ARM: S3C24XX: Add missing DMACH_DT_PROP
>   ARM: S3C24XX: Fix s3c2410_dma_enqueue parameters
> 
>  arch/arm/mach-s3c24xx/include/mach/dma.h |    3 ++-
>  arch/arm/plat-s3c24xx/dma.c              |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --
> 1.7.2.3

Applied this series, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
