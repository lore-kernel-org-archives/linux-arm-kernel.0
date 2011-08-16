From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Aug 2011 09:27:42 +0200
Subject: [PATCH] imx5: not include the unused head file
In-Reply-To: <1312459071-6617-1-git-send-email-jason.hui@linaro.org>
References: <1312459071-6617-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110816072742.GX31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 07:57:51PM +0800, Jason Liu wrote:
> Remove the useless <asm/irq.h> and <linux/irq.h> reference

Applied to cleanups.

Sascha

> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx5/board-cpuimx51.c           |    2 --
>  arch/arm/mach-mx5/board-cpuimx51sd.c         |    2 --
>  arch/arm/mach-mx5/board-mx51_babbage.c       |    1 -
>  arch/arm/mach-mx5/board-mx51_efikamx.c       |    1 -
>  arch/arm/mach-mx5/board-mx51_efikasb.c       |    1 -
>  arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    1 -
>  arch/arm/mach-mx5/mx51_efika.c               |    1 -
>  7 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 7c893fa..afae958 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -22,14 +22,12 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
>  
>  #include <mach/eukrea-baseboards.h>
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx51.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
> index ff096d5..82c0788 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51sd.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
> @@ -22,7 +22,6 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/i2c-gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/can/platform/mcp251x.h>
> @@ -32,7 +31,6 @@
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx51.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index e400b09..c6c74cf 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -24,7 +24,6 @@
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx51.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> index f70700d..8cf7dda 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> @@ -32,7 +32,6 @@
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx51.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
> index 2e4d9d3..eecc592 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikasb.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
> @@ -35,7 +35,6 @@
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx51.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
> index 2619239..1878d09 100644
> --- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
> @@ -24,7 +24,6 @@
>  
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
> diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
> index 4435e03..055515c 100644
> --- a/arch/arm/mach-mx5/mx51_efika.c
> +++ b/arch/arm/mach-mx5/mx51_efika.c
> @@ -34,7 +34,6 @@
>  #include <linux/usb/ulpi.h>
>  #include <mach/ulpi.h>
>  
> -#include <asm/irq.h>
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> -- 
> 1.7.4.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
