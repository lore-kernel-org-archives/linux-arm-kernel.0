From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Thu, 25 Oct 2018 00:44:24 +0000
Subject: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
In-Reply-To: <CAOMZO5Cm2U4dR982vYTmb5zfdjfXbQ95B+mDt2Fp8D-QtvT6FA@mail.gmail.com>
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
 <20181024111213.2724-4-qiangqing.zhang@nxp.com>
 <CAOMZO5Cm2U4dR982vYTmb5zfdjfXbQ95B+mDt2Fp8D-QtvT6FA@mail.gmail.com>
Message-ID: <DB7PR04MB4618CEA5069E3A276E92D22AE6F70@DB7PR04MB4618.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: 2018?10?24? 19:20
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Rob Herring <robh+dt@kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>; A.s. Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support

Hi Joakim,

On Wed, Oct 24, 2018 at 8:15 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> new file mode 100644
> index 000000000000..963e0b559d60
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

You can remove this paragraph as you are using SPDX tag.

> +++ b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Ditto.

> +&can1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flexcan1>;
> +       pinctrl-assert-gpios = <&max7310_b 3 GPIO_ACTIVE_HIGH>; /* TX */

This property does not exist in upstream.


Hi Fabio,

I will modify what you have commented. Thanks a lot.

Best Regards,
Joakim Zhang
