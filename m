From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 27 Jun 2018 01:23:01 +0000
Subject: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
In-Reply-To: <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
References: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
Message-ID: <DB5PR04MB1320492352AFFEB852E74D1AF5480@DB5PR04MB1320.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Wednesday, June 27, 2018 9:21 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; dl-linux-imx <linux-imx@nxp.com>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
> linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
> 
> On Tue, Jun 26, 2018 at 3:08 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > commit (5fe156f regulator: pfuze100: add enable/disable for switch)
> > will cause those unreferenced switches being
> 
> Nit: The proper way to reference a commit is:
> 
> commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
> 
> 12 char for the commit ID and the commit name inside (" ").
> 
> > turned off if "regulator-always-on" is NOT present, as pfuze switches
> > are normally used by critical modules which must be always ON or
> > shared by many peripherals which do NOT implement power domain
> > control, so just make sure all switches always ON to avoid any system
> > issue caused by unexpectedly turning off switches.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks, will improve it and also the other patch for imx6sll.

Anson.
