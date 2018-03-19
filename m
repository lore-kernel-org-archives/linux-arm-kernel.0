From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 19 Mar 2018 01:59:41 +0000
Subject: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
In-Reply-To: <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
 <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
Message-ID: <AM3PR04MB1315E036D33F27C9AF617252F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, March 18, 2018 8:55 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
> 
> On Sat, Mar 17, 2018 at 11:23 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > I thought the max value here means the capability of regulator itself, like the
> internal
> 
> No it is not.
> 
> Please check Documentation/devicetree/bindings/regulator/regulator.txt:
> 
> "- regulator-max-microvolt: largest voltage consumers may set"
 
OK, so I should change the max value of SW1A according to board design, such
as for MX7D, it is 1.075V for max cpu-freq's voltage, set it to 1.075 in dts?

Also, according to the binding doc, do you think the anatop's vdd_arm and vdd_soc/pu's max
value also need to be adjusted to match the value define in each soc's datasheet? 

Anson.
