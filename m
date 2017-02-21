From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 22 Feb 2017 00:21:11 +0100
Subject: [PATCH v2] MAINTAINERS: Add Jon Mason to BCM5301X maintainers
In-Reply-To: <1486597403-9607-1-git-send-email-jon.mason@broadcom.com>
References: <1486597403-9607-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <d6d49f2a-0444-a630-1de3-ed81f7407822@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 12:43 AM, Jon Mason wrote:
> Adding myself as a maintainer for Broadcom Northstar SoCs.  Also, adding
> a regex entry to discover the SVK DTs already present.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2abda6c..70f4b62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2641,12 +2641,14 @@ F:	arch/mips/include/asm/mach-bcm47xx/*
>  BROADCOM BCM5301X ARM ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  M:	Rafa? Mi?ecki <zajec5@gmail.com>
> +M:	Jon Mason <jonmason@broadcom.com>
>  M:	bcm-kernel-feedback-list at broadcom.com
>  L:	linux-arm-kernel at lists.infradead.org
>  S:	Maintained
>  F:	arch/arm/mach-bcm/bcm_5301x.c
>  F:	arch/arm/boot/dts/bcm5301x*.dtsi
>  F:	arch/arm/boot/dts/bcm470*
> +F:	arch/arm/boot/dts/bcm953012*
>  
>  BROADCOM BCM53573 ARM ARCHITECTURE
>  M:	Rafa? Mi?ecki <rafal@milecki.pl>
> 
