From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 15:07:29 +0000
Subject: [PATCH 1/3] ARM i.MX53: enable fec driver on EVK board
In-Reply-To: <1294317033-9194-2-git-send-email-yong.shen@freescale.com>
References: <1294317033-9194-1-git-send-email-yong.shen@freescale.com>
	<1294317033-9194-2-git-send-email-yong.shen@freescale.com>
Message-ID: <20110106150729.GF31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 08:30:31PM +0800, yong.shen at freescale.com wrote:
>  #include <linux/init.h>
>  #include <linux/clk.h>
> +#include <linux/fec.h>
> +#include <linux/delay.h>
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> +#include <mach/gpio.h>

linux/gpio.h please
