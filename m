From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 20 Sep 2018 06:58:08 +0000
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <20180920065219.GT4097@pengutronix.de>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
 <20180919194100.GQ4097@pengutronix.de>
 <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180920063358.GS4097@pengutronix.de>
 <AM0PR04MB4211FB690E079766D364E94F80130@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180920065219.GT4097@pengutronix.de>
Message-ID: <AM0PR04MB4211D52E299818DA41C0299880130@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, September 20, 2018 2:52 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
> 
> On Thu, Sep 20, 2018 at 06:41:15AM +0000, A.s. Dong wrote:
> > > > > Could you give the exported functions a better namespace like
> imx_scu_*?
> > > > >
> > > >
> > > > Good idea.
> > > > Should we change all the rest as well?
> > >
> > > You mean enums and such? Yes, that would be good.
> >
> > I mean other functions and struct names. All prefixed by imx_scu.
> > Enums still not changed.
> 
> I don't really care about stuff that's internal to a single C file, but everything
> that is globally visible should have a proper namespace,
> 

Okay, I got your point. Thanks

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cd7
> bf1b2ed455456369a708d61ec59d9d%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636730231447513240&amp;sdata=y7JI70I5V6KZ0RGlASub
> qEZ5qW02wrFKcEDZgaglAk8%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
