From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 9 Feb 2017 00:29:05 +0100
Subject: [PATCH] MAINTAINERS: Add Jon Mason to BCM5301X maintainers
In-Reply-To: <1486596146-26766-1-git-send-email-jon.mason@broadcom.com>
References: <1486596146-26766-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <d7b40d59-4121-97ef-9829-405df8042bd7@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 12:22 AM, Jon Mason wrote:
> Adding myself as a maintainer for Broadcom Northstar SoCs.  Also, adding
> a regex entry to discover the SVK DTs already present.
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Acked-by: Rafa? Mi?ecki <rafal@milecki.pl>


>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2abda6c..03c1760 100644
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
> +N:	bcm953012

Is it worth using N: (regex pattern)? Just asking.
