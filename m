From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 15 May 2012 08:48:34 +0530
Subject: [PATCH 0/3] dmaengine: at_hdmac: slave configuration
In-Reply-To: <cover.1336644470.git.nicolas.ferre@atmel.com>
References: <cover.1336644470.git.nicolas.ferre@atmel.com>
Message-ID: <1337051914.16185.5293.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-10 at 12:17 +0200, Nicolas Ferre wrote:
> This patch series is composed of two cleanup patches and one "slave
> configuration" patch. The last one uses configuration data passed through the
> slave configuration API to setup the DMA controller.
> Corresponding custom configuration is removed from the slave DMA private
> structure and its use in the AT91 files. Header definitions are then moved
> accordingly.
> 
> Nicolas Ferre (3):
>   dmaengine: at_hdmac: remove some at_dma_slave comments
>   dmaengine: at_hdmac: remove ATC_DEFAULT_CTRLA constant
>   dmaengine: at_hdmac: take maxburst from slave configuration
> 
>  arch/arm/mach-at91/at91sam9g45_devices.c   |    1 -
>  arch/arm/mach-at91/include/mach/at_hdmac.h |   26 --------------------------
>  drivers/dma/at_hdmac.c                     |   15 +++++++--------
>  drivers/dma/at_hdmac_regs.h                |   21 ++++++++++++++++++++-
>  4 files changed, 27 insertions(+), 36 deletions(-)
Applied, Thanks


-- 
~Vinod
