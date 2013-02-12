From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 15:25:22 -0800
Subject: [PATCH] ARM: S3C24XX: remove plat-samsung/irq.h
In-Reply-To: <201302122042.32471.heiko@sntech.de>
References: <201302122042.32471.heiko@sntech.de>
Message-ID: <1dc701ce0978$3c127090$b43751b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> plat-samsung/irq.h did only contain functions for handling the spread out
> subirqs on s3c24xx arches, which are not needed anymore.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Sorry for bringing this separate submission, but I just remembered
> it this evening.
> 
> This applies on top of all the other s3c24xx irq changes and
> I think this patch will mark the end of the irq-cleanup for now.
> 
>  arch/arm/mach-s3c24xx/irq-pm.c           |    7 ++-
>  arch/arm/mach-s3c24xx/irq.c              |    8 +--
>  arch/arm/plat-samsung/include/plat/irq.h |  116 ------------------------------
>  3 files changed, 9 insertions(+), 122 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/irq.h
> 
Applied, thanks :-)

- Kukjin
