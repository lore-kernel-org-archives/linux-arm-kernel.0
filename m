From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 8 Oct 2018 10:38:39 +0000
Subject: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
In-Reply-To: <20181008073010.GO3587@dragon>
References: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
 <20181008073010.GO3587@dragon>
Message-ID: <AM0PR04MB421161DEADF1439C2D8BBB7D80E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/MAINTAINERS b/MAINTAINERS index 9ad052a..d1fb824 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1462,6 +1462,7 @@ F:	arch/arm/mach-mxs/
> >  F:	arch/arm/boot/dts/imx*
> >  F:	arch/arm/configs/imx*_defconfig
> >  F:	drivers/clk/imx/
> > +F:	drivers/firmware/imx/
> 
> Please add include/linux/firmware/imx/ too.
> 

Sorry for missing it. Will update now.

Regards
Dong Aisheng

> Shawn
> 
> >  F:	drivers/soc/imx/
> >  F:	include/soc/imx/
> >
> > --
> > 2.7.4
> >
