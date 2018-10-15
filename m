From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 15 Oct 2018 09:17:59 +0000
Subject: [PATCH V2 2/2] pinctrl: imx: add imx8qxp driver
In-Reply-To: <20181015070648.7ss65nv7ozrsypj2@pengutronix.de>
References: <1539437252-20603-1-git-send-email-aisheng.dong@nxp.com>
 <1539437252-20603-3-git-send-email-aisheng.dong@nxp.com>
 <20181015070648.7ss65nv7ozrsypj2@pengutronix.de>
Message-ID: <AM0PR04MB42113287716E78582C7E513D80FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > diff --git a/include/dt-bindings/pinctrl/pads-imx8qxp.h
> > b/include/dt-bindings/pinctrl/pads-imx8qxp.h
> > new file mode 100644
> > index 0000000..8f477c3
> > --- /dev/null
> > +++ b/include/dt-bindings/pinctrl/pads-imx8qxp.h
> > @@ -0,0 +1,751 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + */
> > +
> > +#ifndef _SC_PADS_H
> > +#define _SC_PADS_H
> > +
> > +/* pin id */
> > +#define SC_P_PCIE_CTRL0_PERST_B                  0
> 
> As said in the thread adding board support: These should have a proper
> IMX8QP_ prefix.
> 

Yes, I will add them, thanks for the suggestion.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C49
> 46ed233f5a4432d45508d6326cc8f9%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636751840141389833&amp;sdata=YtJ2ODYWvV%2F4%2Bj
> v%2FY1foOogv0ncuUc5KE6SPhEX0aVg%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
