From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 6 Aug 2012 22:16:09 +0200
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <20120806193734.GA16199@opensource.wolfsonmicro.com>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
 <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
 <20120806154951.GQ16861@opensource.wolfsonmicro.com>
 <CAKGA1b=_AOub_pEJJGBTb6Y7wLZaSYKQjFTyMVFSr_=9VX4wpg@mail.gmail.com>
 <20120806193734.GA16199@opensource.wolfsonmicro.com>
Message-ID: <20120806201609.GX25644@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 08:37:34PM +0100, Mark Brown wrote:
> As far as I can tell nobody's really running much up to date mainline
> on older i.MX processors, all the work is going on the new stuff and
> most of the board are on either vendor BSPs or older kernels.

That's not true; we still run MX25, MX27, MX35, MX28 on mainline in
active projects.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
