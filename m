From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 11:16:21 +0800
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <DBXPR04MB320A55DE4386DE561A1D4DC80F90@DBXPR04MB320.eurprd04.prod.outlook.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <5e78ef100319f229a87e33804384e5b3@agner.ch>
 <DBXPR04MB320A55DE4386DE561A1D4DC80F90@DBXPR04MB320.eurprd04.prod.outlook.com>
Message-ID: <20170525031620.GS26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 10:37:27AM +0000, A.S. Dong wrote:
> > > +#ifndef __DTS_IMX7ULP_PINFUNC_H
> > > +#define __DTS_IMX7ULP_PINFUNC_H
> > > +
> > > +/*
> > > + * The pin function ID is a tuple of
> > > + * <mux_conf_reg input_reg mux_mode input_val>  */
> > > +
> > > +#define ULP1_PAD_PTC0__PTC0
> > > 0x0000 0x0000 0x1 0x0
> > 
> > 
> > For consistency with other SoCs, can we add MX7 to the define? E.g.
> > MX7ULP1?
> > 
> 
> ULP1 is another SoC name of IMX7ULP.
> And there will be ULP0, ULPx in the future..

What is the external/formal SoC name for ULP0 and ULPx?

> 
> It looks like not big issue, so I did not change it.

It's an easy change to make things more obvious, so +1 on Stefan's
opinion.

Shawn
