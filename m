From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 11:07:13 +0800
Subject: [alsa-devel] [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
In-Reply-To: <20111220005100.GJ2860@opensource.wolfsonmicro.com>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
 <20111220005100.GJ2860@opensource.wolfsonmicro.com>
Message-ID: <20111220030712.GC2995@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 12:51:01AM +0000, Mark Brown wrote:
> On Wed, Dec 14, 2011 at 03:47:46PM +0800, Shawn Guo wrote:
> > The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
> > changes the type of parameter 'direction' of device_prep_dma_cyclic
> > from dma_data_direction to dma_transfer_direction.
> 
> Applied, thanks.
> 
> With patches like this you really need to supply more context - knowing
> which release the commit you're talking about appears in is useful for
> exammple,

This patch only applies to -next, as the offending patch only sits on
-next.

> as is having some hint as to what the rest of the series is
> (does this patch depend on any of the earlier patches, and if not why is
> it part of a series).

The reason it's in the series is that they are addressing the same
problem.

-- 
Regards,
Shawn
