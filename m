From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 29 Apr 2010 13:49:47 +0300
Subject: [PATCH v5 0/2] spi: driver for Cirrus EP93xx SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636DB622A3@AUSP01VMBX24.collaborationhost.net>
References: <cover.1272476431.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636DB622A3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100429104947.GK26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 05:30:25PM -0500, H Hartley Sweeten wrote:
> On Wednesday, April 28, 2010 10:51 AM, Mika Westerberg wrote:
> > 
> > Hello,
> > 
> > This series implements SPI master driver for Cirrus Logic EP93xx SPI
> > controllers.
> > 
> > This is fifth iteration of the driver.
> > 
> > Changes to the previous version:
> > 	- addressed review comments
> > 	- added priming the TX FIFO when transfer is started
> > 	- in case of ROR interrupt we clear it
> > 	- added documentation in Documentation/spi/ep93xx_spi which provides
> > 	  sample code how the driver can be hooked into platform data
> > 
> > I tested this on TS-7260 board with at25 and mmc_spi drivers. Now that I have
> > Sim.One board, which is EP9307 based, I also tested with that (I hacked the
> > board a bit to get EGPIO9 as a chip select).
> > 
> > Note that patch 2/2 depends on patch that is already in Russell's patch
> > tracking system:
> > 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1
> > 
> 
> Mika,
> 
> Following is a patch to allow using built-in gpios, external gpio expanders
> (spi/i2c/etc.) or really any other mechanism for the chip select.

Ok, thanks. I'll wait a bit if there are more comments and then
incorporate your patch along with your review comments and post v6.
I'm really hoping that v6 would be last revision.

Regards,
MW
