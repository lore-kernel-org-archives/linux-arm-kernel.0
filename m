From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Jul 2012 07:39:49 +0200
Subject: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120705005143.GF2595@S2101-09.ap.freescale.net>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-6-git-send-email-marex@denx.de>
 <20120705005143.GF2595@S2101-09.ap.freescale.net>
Message-ID: <201207050739.49912.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Fri, Jun 29, 2012 at 10:22:58AM +0200, Marek Vasut wrote:
> > +config SPI_MXS
> > +	tristate "Freescale MXS SPI controller"
> > +	depends on ARCH_MXS
> > +	help
> > +	  SPI driver for Freescale MXS devices.
> > +
> 
> ...
> 
> > +	stmp_reset_block(ssp->base);
> > +
> 
> So SPI_MXS may need to select STMP_DEVICE.

Ok, fixed in my tree. But, where's the meteor shower of nitpicks and such stuff? 
Or is the driver so good you have nothing to pick on? ;-)

Best regards,
Marek Vasut
