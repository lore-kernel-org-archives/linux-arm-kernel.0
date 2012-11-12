From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 15:17:20 +0000
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <1352645834-10173-1-git-send-email-csd@broadcom.com>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
Message-ID: <20121112151720.GG28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2012 at 06:57:14AM -0800, Christian Daudt wrote:
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <asm/io.h>

Please use linux/io.h rather than asm/io.h throughout your patch sets.
However, I don't see anything in this file which requires this header,
so it's better off being removed entirely.
