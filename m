From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 10:36:40 +0100
Subject: [RFC][PATCH 4/5] ARM: S5P64x0: Adding OTG PHY control code
In-Reply-To: <1308639827-2121-5-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
	<1308639827-2121-5-git-send-email-p.paneri@samsung.com>
Message-ID: <20110621093640.GB23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 12:33:46PM +0530, p.paneri at samsung.com wrote:
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <mach/regs-clock.h>
> +#include <mach/gpio.h>

linux/gpio.h please.
