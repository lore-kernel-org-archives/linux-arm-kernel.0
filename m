From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 21:06:16 +0100
Subject: [PATCHv12][ 4/8] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383727939-4190-4-git-send-email-denis@eukrea.com>
References: <1383727939-4190-1-git-send-email-denis@eukrea.com>
 <1383727939-4190-4-git-send-email-denis@eukrea.com>
Message-ID: <CACRpkdYBbL2giVBRj8cP0HNid+TUyvubSkfHkEs5QP=i=aCjWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 9:52 AM, Denis Carikli <denis@eukrea.com> wrote:

> This is mostly cut and paste from the imx35 pinctrl driver.
> The data was generated using sed and awk on
>   arch/arm/plat-mxc/include/mach/iomux-mx25.h.
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ChangeLog v10->v11:
> - Added Shawn Guo in the Cc list.
> - Splitted the patch to be only pinctrl driver specific.
> - Removed the group control registers, and the PAD_CTL_DRIVE_VOLAGAGE_* pad configurations.
>   (They were not used).

OK this has Sascha's ACK and Shawn is not complaining about
it so patch applied!

However...

> +++ b/drivers/pinctrl/pinctrl-imx25.c
> @@ -0,0 +1,351 @@
> +/*
> + * imx25 pinctrl driver.
> + *
> + * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
> + *
> + * This driver was mostly copied from the imx51 pinctrl driver which has:
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Linaro, Inc.
> + *
> + * Author: Dong Aisheng <dong.aisheng@linaro.org>

I changed this to your name when applying.

Yours,
Linus Walleij
