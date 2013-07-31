From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 13:49:14 -0600
Subject: [PATCH 9/10] ARM: dts: tx28: restructure and update DTS file
In-Reply-To: <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <51F96A3A.30409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 08:37 AM, Lothar Wa?mann wrote:

This patch is definitely too invasive not to have a description.

> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts

> + * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>

I don't think you're the only person who wrote these. Perhaps other
people should be listed here too?

> +#define USE_SPI_GPIO

What's that?

> +	chosen {
> +		bootargs = "init=/linuxrc console=ttyAMA0,115200 root=/dev/mtdblock3 rootfstype=jffs2 ro debug panic=1";
> +	};

I think this should be set by the bootloader, not hard-coded.
