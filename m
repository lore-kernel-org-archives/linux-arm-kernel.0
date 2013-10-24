From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Oct 2013 23:26:09 +0800
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <1382076260-6422-8-git-send-email-gerg@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
Message-ID: <20131024152606.GE14529@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 04:04:19PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Create device tree bindings for the Freescale IMX50 SoC. This was based on

I think it's a device tree source rather than bindings.

> the IMX53 bindings with changes made as necessary.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/boot/dts/imx50.dtsi | 659 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 659 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx50.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> new file mode 100644
> index 0000000..c4de7ac
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -0,0 +1,659 @@
> +/*
> + * Copyright 2013 Greg Ungerer <gerg@uclinux.org>
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include "skeleton.dtsi"
> +#include "imx50-pinfunc.h"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		gpio5 = &gpio6;

Please sort these aliases alphabetically.

Shawn

> +	};
