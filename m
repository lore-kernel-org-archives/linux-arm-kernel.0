From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 18 Jan 2018 10:53:51 +0100
Subject: [PATCH] net: fec: add necessary defines to work on ARM64
In-Reply-To: <AM4PR0401MB2260FA4491320B2A9384DB96FFE80@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180117183055.27602-1-l.stach@pengutronix.de>
 <AM4PR0401MB2260FA4491320B2A9384DB96FFE80@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Message-ID: <1516269231.19307.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Donnerstag, den 18.01.2018, 01:49 +0000 schrieb Andy Duan:
> From: Lucas Stach <l.stach@pengutronix.de> Sent: Thursday, January
> 18, 2018 2:31 AM
> > The i.MX8 is a ARMv8 based SoC, that uses the same FEC IP as the
> > earlier,
> > ARMv7 based, i.MX SoCs. Allow the driver to work on ARM64.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
[...]

> Kconfig also need to add ARM64 support.

No, not as far as I'm aware. I introduced the ARCH_MXC symbol for
ARM64, which unlocks the FEC config option when selected.

Regards,
Lucas
