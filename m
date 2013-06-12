From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Jun 2013 14:49:57 +0530
Subject: [PATCH v3] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <1369923812-21767-1-git-send-email-shawn.guo@linaro.org>
References: <1369923812-21767-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130612091957.GQ4107@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 10:23:32PM +0800, Shawn Guo wrote:
> Update imx-sdma driver to adopt generic DMA device tree bindings.  It
> calls of_dma_controller_register() with imx-sdma specific of_dma_xlate
> to get the generic DMA device tree helper support.  The #dma-cells for
> imx-sdma must be 3, which includes request ID, peripheral type and
> priority.
> 
> The existing way of requesting channel, clients directly call
> dma_request_channel(), still work there, and will be removed after
> all imx-sdma clients get converted to generic DMA device tree helper.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Applied, thanks

--
~Vinod
