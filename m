From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Sep 2018 08:52:20 +0200
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <AM0PR04MB4211FB690E079766D364E94F80130@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
 <20180919194100.GQ4097@pengutronix.de>
 <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180920063358.GS4097@pengutronix.de>
 <AM0PR04MB4211FB690E079766D364E94F80130@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180920065219.GT4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 06:41:15AM +0000, A.s. Dong wrote:
> > > > Could you give the exported functions a better namespace like imx_scu_*?
> > > >
> > >
> > > Good idea.
> > > Should we change all the rest as well?
> > 
> > You mean enums and such? Yes, that would be good.
> 
> I mean other functions and struct names. All prefixed by imx_scu.
> Enums still not changed.

I don't really care about stuff that's internal to a single C file, but
everything that is globally visible should have a proper namespace,

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
