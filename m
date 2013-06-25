From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 17:44:06 +0200
Subject: [RFC PATCH v2 00/12] ARM: s3c64xx: Let amba-pl08x driver handle
 DMA
In-Reply-To: <20130625153843.GF27646@sirena.org.uk>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <6520269.XdaOpEg0Ud@amdc1227> <20130625153843.GF27646@sirena.org.uk>
Message-ID: <1486283.2pMLZtfT9J@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of June 2013 16:38:43 Mark Brown wrote:
> On Tue, Jun 25, 2013 at 01:22:20PM +0200, Tomasz Figa wrote:
> > On Tuesday 25 of June 2013 11:28:18 Mark Brown wrote:
> > > On my non-DT s3c64xx system I get this when trying to use SPI for the
> > 
> > > first time:
> > Could you clarify first time? Does it work on further retries?
> 
> No, the system appears to lock up fairly solidly - I suspect poor error
> handling in the SPI driver.
> 
> > > [    1.739385] s3c64xx-spi s3c6410-spi.0: Failed to get RX DMA
> > > channel
> > > [    1.743437] spi_master spi0: failed to prepare transfer hardware
> > > 
> > > though I haven't yet tried your clock patches (there were some
> > > conficts
> > > that I didn't get round to picking up yet).
> > 
> > This shouldn't really matter, as long as the pl080 drivers probes
> > correctly.
> 
> Indeed, I was wondering if it was failing to probe due to not getting
> its clocks though since that's another area you've been actively working
> on.

Let me check if I can get something with SPI interface that I would be able 
to connect to my board at home and do some testing.

Best regards,
Tomasz
