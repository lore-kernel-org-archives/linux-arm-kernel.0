From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 23:17:37 +0000
Subject: [PATCH 05/12] spi: mxs-spi: move to use generic DMA helper
In-Reply-To: <1361978748-25281-6-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130302231737.D2D743E36A2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Feb 2013 23:25:41 +0800, Shawn Guo <shawn.guo@linaro.org> wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Since mxs is a DT only platform now, along with the changes, the non-DT
> case handling in probe function also gets removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: spi-devel-general at lists.sourceforge.net

Acked-by: Grant Likely <grant.likely@secretlab.ca>
