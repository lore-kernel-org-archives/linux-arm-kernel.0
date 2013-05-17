From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 17:08:17 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <1368684648-20826-3-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-3-git-send-email-b35083@freescale.com>
Message-ID: <20130517090815.GH8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:10:46PM +0800, Jingchang Lu wrote:
> Add initial support for Vybrid MVF600 SoC.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v3:
>   remove unused #include header lines.

There are more ...

> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/clocksource.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <asm/mach/arch.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/system_misc.h>

#include <linux/delay.h>
#include <linux/clk.h>
#include <linux/irqchip/arm-gic.h>
#include <asm/system_misc.h>

I do not see how these 4 headers are needed.

Shawn
