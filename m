From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jul 2011 10:25:21 +0200
Subject: [PATCH 1/2] dmaengine: imx-sdma: use platform_device_id to
	identify sdma version
In-Reply-To: <20110715082204.GD1840@S2100-06.ap.freescale.net>
References: <1310660057-17953-1-git-send-email-shawn.guo@linaro.org>
	<1310660057-17953-2-git-send-email-shawn.guo@linaro.org>
	<20110715080132.GI6069@pengutronix.de>
	<20110715082204.GD1840@S2100-06.ap.freescale.net>
Message-ID: <20110715082521.GL6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 04:22:05PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> On Fri, Jul 15, 2011 at 10:01:32AM +0200, Sascha Hauer wrote:
> > On Fri, Jul 15, 2011 at 12:14:16AM +0800, Shawn Guo wrote:
> > > It might be not good to use software defined version to identify sdma
> > > device type, when hardware does not define such version.  Instead,
> > > soc name is stable enough to define the device type.
> > > 
> > > The patch uses platform_device_id rather than version number passed
> > > by platform data to identify sdma device type/version.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Generally Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > However, I find no branch to apply this on. This patch *mostly* applied
> > after I merged Grants gpio-next branch into mine and resolved the
> > resulting merge conflicts.
> > 
> I appreciate it, if you can do that.

Do what? apply it mostly?

>  Otherwise, maybe we can let it
> rest for a while until all trees get merged in coming -rc window.

Yes please. I don't want to move i.MX in the merge conflict focus again,
this wouldn't be good for all of us.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
