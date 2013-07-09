From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Jul 2013 09:51:24 +0200
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <51DBBFDA.70302@freescale.com>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de>
 <51DBBFDA.70302@freescale.com>
Message-ID: <20130709075124.GR516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 03:46:34PM +0800, Huang Shijie wrote:
> ? 2013?07?09? 15:05, Sascha Hauer ??:
> >Why don't you set the matching order in the driver the way you want it
> >to be, i.e.:
> >
> >	{ .compatible = "fsl,imx6q-uart", ... },
> >	{ .compatible = "fsl,imx21-uart", ... },
> >	{ .compatible = "fsl,imx1-uart", ... },
> >
> yes. i can set it like this.
> 
> but this method looks like a ugly workaround.

If a driver has different ways of supporting a single device, then
putting the preferred or most feature rich on top doesn't look very ugly
to me.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
