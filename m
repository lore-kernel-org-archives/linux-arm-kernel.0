From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 4 May 2015 23:33:00 +0200
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150504212457.GB4810@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
 <20150504211150.GU15254@pengutronix.de>
 <20150504212457.GB4810@atomide.com>
Message-ID: <20150504213300.GV15254@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 02:24:57PM -0700, Tony Lindgren wrote:
> > I tried this, with the patch below, but it doesn't work:
> 
> With the above the tptc instances are being probed as separate
> device entries that do not register with tpcc without the
> related driver changes. I don't think we even parse the
> compatible = "ti,tptc3" property currently.

How useful is it to let the driver warn about wrong devicetrees then,
when fixing the devicetrees results in a kernel not supporting it...?

Shouldn't these sort of patches being upstreamed only together with the
full set of changes?

However, thanks for the infos, I'll stay with the warnings for now.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
