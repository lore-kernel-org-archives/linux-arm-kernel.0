From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Mar 2011 12:11:38 +0000
Subject: [PATCH] ARM: imx: Add tlv320aic32x4 board specific code to
	Visstrim_M10.
In-Reply-To: <1299499439-4466-1-git-send-email-javier.martin@vista-silicon.com>
References: <1299499439-4466-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20110307121138.GD1829@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 01:03:59PM +0100, Javier Martin wrote:

> @@ -30,6 +30,7 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/gpio.h>
> +#include <sound/tlv320aic32x4.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>

Note that this only just got merged into -next so won't build in the ARM
tree until after the merge window.
