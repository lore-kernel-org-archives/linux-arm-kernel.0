From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 11:09:14 +0800
Subject: [PATCH 5/8] ARM: dts: add i.mx6ul pin function include file
In-Reply-To: <1434555569-8237-6-git-send-email-Frank.Li@freescale.com>
References: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
 <1434555569-8237-6-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150709030913.GA23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:39:26PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> add pin mux define file
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx6ul-pinfunc.h | 938 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 938 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-pinfunc.h
> 
> diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h b/arch/arm/boot/dts/imx6ul-pinfunc.h
> new file mode 100644
> index 0000000..1bb774b9
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-pinfunc.h
> @@ -0,0 +1,938 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DTS_IMX6UL_PINFUNC_H
> +#define __DTS_IMX6UL_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <mux_reg conf_reg input_reg mux_mode input_val>
> + */
> +#define	MX6UL_PAD_BOOT_MODE0__GPIO5_IO10				0x0014 0x02A0 0x0000 5 0

Please use space instead of tab between #define and macro.  And if
possible, please change your scripts to use lowercase in hex value,
so that we are consistent with other i.MX pinfunc headers.

Shawn
