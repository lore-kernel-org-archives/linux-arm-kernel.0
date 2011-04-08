From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Apr 2011 23:03:46 +0100
Subject: [PATCH] ux500: Adding support for u8500 Hsem functionality.
In-Reply-To: <1302294509-6595-1-git-send-email-mathieu.poirier@linaro.org>
References: <1302294509-6595-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20110408220346.GD5573@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 02:28:29PM -0600, mathieu.poirier at linaro.org wrote:
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/hwspinlock.h>
> +#include <linux/platform_device.h>
> +#include <asm/mach-types.h>

Do you need all the above?  I don't think at least mach-types.h is
required.
