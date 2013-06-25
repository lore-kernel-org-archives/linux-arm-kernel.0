From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 13:22:20 +0200
Subject: [RFC PATCH v2 00/12] ARM: s3c64xx: Let amba-pl08x driver handle
 DMA
In-Reply-To: <20130625102818.GA27646@sirena.org.uk>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <20130625102818.GA27646@sirena.org.uk>
Message-ID: <6520269.XdaOpEg0Ud@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for testing this series.

On Tuesday 25 of June 2013 11:28:18 Mark Brown wrote:
> On Sat, Jun 22, 2013 at 10:42:32PM +0200, Tomasz Figa wrote:
> > This is another version of my patches extending support of amba-pl08x
> > DMA engine driver to PL080S DMA engine (PL080 modified by Samsung)
> > found
> > in Samsung S3C64xx SoCs.
> 
> On my non-DT s3c64xx system I get this when trying to use SPI for the
> first time:

Could you clarify first time? Does it work on further retries?

> [    1.739385] s3c64xx-spi s3c6410-spi.0: Failed to get RX DMA channel
> [    1.743437] spi_master spi0: failed to prepare transfer hardware
> 
> though I haven't yet tried your clock patches (there were some conficts
> that I didn't get round to picking up yet).

This shouldn't really matter, as long as the pl080 drivers probes 
correctly.

Best regards,
Tomasz
