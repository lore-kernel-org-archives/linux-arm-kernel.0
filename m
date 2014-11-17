From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 17 Nov 2014 12:57:21 +0000
Subject: [PATCH] MAINTAINERS: update email address and cleanup for exynos
 entry
In-Reply-To: <1415951697-5991-1-git-send-email-kgene@kernel.org>
References: <1415951697-5991-1-git-send-email-kgene@kernel.org>
Message-ID: <5469F0B1.6010907@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/14 07:54, Kukjin Kim wrote:
> Use kernel.org account instead of samsung.com and cleanup for Samsung
> s3c, s5p and exynos SoCs.
> 
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>

I do wish these would be sent to the mail address I use for
Linux related issues. I only want to see work related Linux
issues to my <ben.dooks@codethink.co.uk> address.

It is sad to see my entries removed, but I no longer have time
to maintain these.

> Signed-off-by: Kukjin Kim <kgene@kernel.org>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  MAINTAINERS |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b1163..b1e27bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1308,30 +1308,22 @@ F:	drivers/*/*rockchip*
>  F:	drivers/*/*/*rockchip*
>  F:	sound/soc/rockchip/
>  
> -ARM/SAMSUNG ARM ARCHITECTURES
> -M:	Ben Dooks <ben-linux@fluff.org>
> -M:	Kukjin Kim <kgene.kim@samsung.com>
> +ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
> +M:	Kukjin Kim <kgene@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
> -W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  F:	arch/arm/boot/dts/s3c*
>  F:	arch/arm/boot/dts/exynos*
>  F:	arch/arm/plat-samsung/
>  F:	arch/arm/mach-s3c24*/
>  F:	arch/arm/mach-s3c64xx/
> +F:	arch/arm/mach-s5p*/
> +F:	arch/arm/mach-exynos*/
>  F:	drivers/*/*s3c2410*
>  F:	drivers/*/*/*s3c2410*
>  F:	drivers/spi/spi-s3c*
>  F:	sound/soc/samsung/*
> -
> -ARM/S5P EXYNOS ARM ARCHITECTURES
> -M:	Kukjin Kim <kgene.kim@samsung.com>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
> -S:	Maintained
> -F:	arch/arm/mach-s5p*/
> -F:	arch/arm/mach-exynos*/
>  N:	exynos
>  
>  ARM/SAMSUNG MOBILE MACHINE SUPPORT
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
