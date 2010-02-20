From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Feb 2010 16:34:52 +0000
Subject: [PATCH 06/13] ARM: LPC32XX: Serial support code
In-Reply-To: <1266621969-28847-7-git-send-email-wellsk40@gmail.com>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
	<1266621969-28847-7-git-send-email-wellsk40@gmail.com>
Message-ID: <20100220163452.GB12409@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2010 at 03:26:02PM -0800, wellsk40 at gmail.com wrote:
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include <mach/io.h>

mach/io.h is not required.
