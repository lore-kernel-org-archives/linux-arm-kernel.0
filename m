From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 11:43:42 +0100
Subject: [PATCH v2] arm/imx: fix the references to ARCH_MX3
In-Reply-To: <1321883269.32195.9.camel@x61.thuisdomein>
References: <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
 <1320997034-10051-1-git-send-email-shawn.guo@linaro.org>
 <1321883269.32195.9.camel@x61.thuisdomein>
Message-ID: <20111122104342.GH27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:47:49PM +0100, Paul Bolle wrote:
> On Fri, 2011-11-11 at 15:37 +0800, Shawn Guo wrote: 
> > The config symbol ARCH_MX3 has been removed by commit 'a89cf59
> > arm/imx: merge i.MX3 and i.MX6', and it should not be referenced
> > any more.
> > 
> > The patch also change ARCH_MX* to SOC_IMX* for other platforms.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > Changes since v1:
> >  * Drop changes on drivers/dma/Kconfig, as Sascha alreay has a patch
> >    to fix it.
> 
> This appears to be to the patch that ended up as commit 59198b6cb2 in
> the mainline tree. But in mainline there are still those two references
> to ARCH_MX3 in drivers/dma/Kconfig. Can I ask what happened to this
> patch of Sascha that Shawn mentions?

I just resent this.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
