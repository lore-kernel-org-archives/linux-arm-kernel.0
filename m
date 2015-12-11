From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 10 Dec 2015 17:57:31 -0800
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <566A2D8B.6020201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/12/2015 15:38, Rob Herring a ?crit :
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
[snip]

> @@ -2300,6 +2314,7 @@ F:	arch/arm/mach-bcm/
>  F:	arch/arm/boot/dts/bcm113*
>  F:	arch/arm/boot/dts/bcm216*
>  F:	arch/arm/boot/dts/bcm281*
> +F:	arch/arm64/boot/dts/broadcom/
>  F:	arch/arm/configs/bcm_defconfig
>  F:	drivers/mmc/host/sdhci-bcm-kona.c
>  F:	drivers/clocksource/bcm_kona_timer.c

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
