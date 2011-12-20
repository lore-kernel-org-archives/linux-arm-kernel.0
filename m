From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 00:51:01 +0000
Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
In-Reply-To: <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111220005100.GJ2860@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 03:47:46PM +0800, Shawn Guo wrote:
> The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
> changes the type of parameter 'direction' of device_prep_dma_cyclic
> from dma_data_direction to dma_transfer_direction.

Applied, thanks.

With patches like this you really need to supply more context - knowing
which release the commit you're talking about appears in is useful for
exammple, as is having some hint as to what the rest of the series is
(does this patch depend on any of the earlier patches, and if not why is
it part of a series).
