From: yibin.gong@nxp.com (Robin Gong)
Date: Mon, 6 Aug 2018 02:34:43 +0000
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
Message-ID: <DB6PR04MB3223362445234D81383F0D1689200@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> >> Not all boards follow the reference design, that's a fact of life.
> >>
> >> Please look at the i.MX6Q reference manual. The sequence implemented
> >> in this patchset can be found as a valid way to power off the system
> >> in
> >> "60.4.3 Power mode transitions" "Normal ON to OFF with external
> >> PMIC", so there is hardly any way to argue that this is a board
> >> specific quirk. This is one of the Freescale/NXP recommended sequences to
> turn off the system.
> 
> > Okay, but could you add one more comment for this solution? RTC alarm
> > and ONOFF Button wakeup feature can't be support in this case.
> 
> Enough to add it in to changelog? or should it go to the binding documentation?
The binding doc is better.
