From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 09:02:30 +0100
Subject: [PATCH] Add support for Vista Silicon Visstrim_m10 board [v4].
In-Reply-To: <1279785529-9679-1-git-send-email-javier.martin@vista-silicon.com>
References: <1279785529-9679-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20100722080230.GG6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <mach/common.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/gpio.h>
> +#include <mach/mmc.h>
> +#include <mach/iomux.h>
> +#include <mach/mxc_ehci.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/pca953x.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>

linux/ includes first, then asm/ includes, then mach/ includes.  Please
use linux/gpio.h rather than mach/gpio.h
