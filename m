From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 21:31:21 +0800
Subject: [PATCH 3/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
In-Reply-To: <1494592686-30967-5-git-send-email-aisheng.dong@nxp.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170515133120.GX8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 08:38:04PM +0800, Dong Aisheng wrote:
> diff --git a/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h b/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h
> new file mode 100644
> index 0000000..b6db73f
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/imx7ulp-pinfunc.h
> @@ -0,0 +1,468 @@
> +/*
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DTS_ULP1_PINFUNC_H
> +#define __DTS_ULP1_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <mux_conf_reg conf_reg input_reg mux_mode input_val>

Forgot this one: it should have only 4 integers.

Shawn

> + */
> +
> +#define ULP1_PAD_PTC0__PTC0                                       0x0000 0x0000 0x1 0x0
> +#define ULP1_PAD_PTC0__TRACE_D15                                  0x0000 0x0000 0xa 0x0
> +#define ULP1_PAD_PTC0__LPUART4_CTS_B                              0x0000 0x0244 0x4 0x1
