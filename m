From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Feb 2011 21:48:19 +0800
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110222080905.GB16141@S2101-09.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
	<20110221174016.GN2616@pengutronix.de>
	<20110222080905.GB16141@S2101-09.ap.freescale.net>
Message-ID: <20110224134818.GA1404@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore the message which is the one I sent a few days ago
and I thought it did not get through.

On Tue, Feb 22, 2011 at 04:09:06PM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Mon, Feb 21, 2011 at 06:40:16PM +0100, Wolfram Sang wrote:
> > Shawn,
> > 
> > On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> > > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > > The driver calls into mxs-dma via generic dmaengine api for both pio
> > > and data transfer.
> > > 
> > > Thanks Chris Ball for the indentation patch.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > What throughput rates do you get on a mx28-regulated slot serving a card
> > at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
> 
> To make sure we are on the same page, can you share me the test you
> ran?  And I can give it a try on my board.
> 
> > board issue though (or we can fix it later), rest works fine, thus:
> > 
> > Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> > 
> 
> -- 
> Regards,
> Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Shawn
