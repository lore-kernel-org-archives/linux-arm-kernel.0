From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH 0/2] Remove hw_addr dma leftovers from S3C24xx machs
In-Reply-To: <201108101227.32780.heiko@sntech.de>
References: <201108101227.32780.heiko@sntech.de>
Message-ID: <000301cc5e30$39f12d50$add387f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> While trying to sort the dma for S3C2416 I stumbled open the hw_addr
> declarations in the other dma.c files.
> 
> It took me a while to figure out that they seem to be some sort
> of leftover, i.e. they are used in dma-pl080.c of the old Samsung
> kernels based on 2.6.21 but nowhere in current kernels.
> 
> Therefore I think removing this stuff is appropriate.
> 
> The patches apply against current linux-next and are
> compile-tested against s3c2410_defconfig and mini2440_defconfig.
> 
> Heiko Stuebner (2):
>   Remove hw_addr from s3c24XX dma channel declarations
>   Remove s3c24xx_dma_addr definition
> 
>  arch/arm/mach-s3c2410/dma.c                      |   14 -----------
>  arch/arm/mach-s3c2412/dma.c                      |   18 --------------
>  arch/arm/mach-s3c2440/dma.c                      |   17 -------------
>  arch/arm/mach-s3c2443/dma.c                      |   27
----------------------
>  arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |    6 -----
>  5 files changed, 0 insertions(+), 82 deletions(-)
> 
> --
> 1.7.5.4

Good :)
Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
