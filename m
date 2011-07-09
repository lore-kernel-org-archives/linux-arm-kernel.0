From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 9 Jul 2011 14:44:41 +0800
Subject: [PATCH 0/6] Add device tree support for imx spi driver
In-Reply-To: <20110708190142.GD9070@ponder.secretlab.ca>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<20110708190142.GD9070@ponder.secretlab.ca>
Message-ID: <20110709064440.GD13962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 01:01:42PM -0600, Grant Likely wrote:
> On Fri, Jul 08, 2011 at 04:27:28PM +0800, Shawn Guo wrote:
> > The patch set makes some cleanups on imx spi driver to get it ready
> > for adding device tree probe and then add the support.
> > 
> > Those two dt helper function related patches are carried here to
> > resolve the dependency.  They should be on the way to sit on Grant's
> > devicetree/next branch.
> > 
> > Rob Herring (1):
> >       dt: add helper function to read u32 arrays
> > 
> > Shawn Guo (5):
> >       ARM: mxc: remove unnecessary header file inclusion from gpio.h
> >       spi/imx: use soc name in spi device type naming scheme
> >       spi/imx: copy gpio number passed by platform data into driver private data
> >       dt: add empty of_property_read_u32[_array] for non-dt
> >       spi/imx: add device tree probe support
> 
> Okay, I tried to apply this series, but the first patch that removes
> the includes caused a build failure, so I've dropped it.  What tree
> are these patches based on top of?
> 
I based the series off linux-next.  Since it will go through your
spi/next tree, I will repost the series against it, with splitting
patch #2 into small pieces to address Sascha's comment.

-- 
Regards,
Shawn
