From: ping.bai@nxp.com (Jacky Bai)
Date: Wed, 7 Feb 2018 10:02:35 +0000
Subject: [PATCH v3 2/2] driver: pinctrl: imx: Add pinctrl driver support
 for imx6sll
In-Reply-To: <CAOMZO5C0Xn9eaShFpUOfE4PZwVGWwHFX3k5k-fzsSA46ataxdw@mail.gmail.com>
References: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
 <1517969226-13076-2-git-send-email-ping.bai@nxp.com>
 <CAOMZO5C0Xn9eaShFpUOfE4PZwVGWwHFX3k5k-fzsSA46ataxdw@mail.gmail.com>
Message-ID: <HE1PR04MB3113931923B40F7378DE58C287FC0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Wed, Feb 7, 2018 at 12:07 AM, Bai Ping <ping.bai@nxp.com> wrote:
> 
> > --- /dev/null
> > +++ b/drivers/pinctrl/freescale/pinctrl-imx6sll.c
> > @@ -0,0 +1,427 @@
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> 
> You could use SPDX identifier.
> 
> > +static int imx6sll_pinctrl_probe(struct platform_device *pdev) {
> > +       pr_info("imx6sll pinctrl probe\n\n\n");
> 
> Please remove this pr_info() line.

Thanks for review. Will fix it.

BR
Jacky Bai
