From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 21:20:28 +0100
Subject: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
In-Reply-To: <20151201172212.GC1696@localhost>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
 <20151201172212.GC1696@localhost>
Message-ID: <1589780.JL62pLTh05@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 22:52:12 Vinod Koul wrote:
> On Mon, Nov 30, 2015 at 03:45:34PM +0200, Peter Ujfalusi wrote:
> > Add support for providing device to filter_fn mapping so client drivers
> > can switch to use the dma_request_chan() API.
> 
> Any reason why we dont want to go with DT based only for edma here?

I think the OMAP2 based platforms using edma are all DT-only, but mach-davinci
would need a lot of work for that.

	Arnd
