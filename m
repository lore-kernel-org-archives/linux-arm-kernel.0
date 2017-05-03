From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:28:19 +0800
Subject: [PATCH v2 6/7] ARM: dts: imx7d: Add node for PCIe controller
In-Reply-To: <20170418150133.31679-7-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
 <20170418150133.31679-7-andrew.smirnov@gmail.com>
Message-ID: <20170503082817.GD18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:01:32AM -0700, Andrey Smirnov wrote:
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
>  arch/arm/boot/dts/imx7d.dtsi | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index f6dee41..f46814a 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -42,6 +42,7 @@
>   */
>  
>  #include "imx7s.dtsi"
> +#include <dt-bindings/reset/imx7-reset.h>

It has dependency on imx7 reset driver, and I need to wait for
v4.12-rc1 to apply the patch.

Shawn
