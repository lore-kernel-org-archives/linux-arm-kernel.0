From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 12:50:05 +0000
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <20120917230615.GA26502@codeaurora.org>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <201209172042.11860.arnd@arndb.de> <20120917230615.GA26502@codeaurora.org>
Message-ID: <201209181250.05647.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, David Brown wrote:
> There is also a lot of similarity between the mmci hardware and the
> msm_sdcc hardware.  Enough so, that it is probably better for us to
> make the mmci driver work with our hardware, rather than trying to
> keep msm_sdcc going.
> 
> There is also an MSM nand device that appears to have not made it in.
> It is heavily dependent on the weird features of the DMA hardware.  I
> don't have any current plans to support this device, since most boards
> using MSMs these days are using mmc/sd instead of bare NAND.
> 
> Our DMA hardware is really weird, but should be a bit reasonable.  It
> is also being gradually replaced in newer chips with a different DMA
> framework.
> 
> As far as I'm concerned, I consider making our DMA driver(s) use the
> DMA engine API to be part of getting these platforms working with DT.
> 
> It is planned, but there are quite a few things that need to be
> tackled first.

Ok, thanks for the information.

	Arnd
