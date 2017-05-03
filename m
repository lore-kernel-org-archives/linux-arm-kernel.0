From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:26:36 +0800
Subject: [PATCH v2 3/7] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <20170418150133.31679-4-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
 <20170418150133.31679-4-andrew.smirnov@gmail.com>
Message-ID: <20170503082634.GC18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:01:29AM -0700, Andrey Smirnov wrote:
> Add node for GPC and specify as a parent interrupt controller for SoC bus.
> 
> Cc: yurovsky at gmail.com
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 7148eac..5ba1289 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -42,6 +42,7 @@
>   */
>  
>  #include <dt-bindings/clock/imx7d-clock.h>
> +#include <dt-bindings/power/imx7-power.h>

It has dependency on imx7 power domain driver, and I need to wait for
v4.12-rc1 to apply the patch.

Shawn

>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
