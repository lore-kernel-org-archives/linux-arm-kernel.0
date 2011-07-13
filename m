From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jul 2011 09:34:33 +0100
Subject: [PATCH] ARM: EXYNOS4: Add platform device for dwmci driver.
In-Reply-To: <1310541479-32252-1-git-send-email-tgih.jun@samsung.com>
References: <1310541479-32252-1-git-send-email-tgih.jun@samsung.com>
Message-ID: <20110713083433.GG23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 04:17:59PM +0900, Seungwon Jeon wrote:
> +#include <linux/kernel.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mmc/dw_mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/io.h>
> +
> +#include <mach/map.h>
> +#include <mach/gpio.h>

This should be linux/gpio.h
