From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 08:23:05 +0100
Subject: [PATCH 08/13] PXA: Colibri: Toradex Colibri PXA270 CF support
In-Reply-To: <1281673964-2119-8-git-send-email-marek.vasut@gmail.com>
References: <1281673964-2119-1-git-send-email-marek.vasut@gmail.com>
	<1281673964-2119-8-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100901072304.GE8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 06:32:39AM +0200, Marek Vasut wrote:
> diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
> new file mode 100644
> index 0000000..8373816
> --- /dev/null
> +++ b/drivers/pcmcia/pxa2xx_colibri.c
> @@ -0,0 +1,215 @@
> +/*
> + * linux/drivers/pcmcia/pxa2xx_colibri.c
> + *
> + * Driver for Toradex Colibri PXA270 CF socket
> + *
> + * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +
> +#include <asm/mach-types.h>
> +
> +#include <mach/gpio.h>

linux/gpio.h please.
