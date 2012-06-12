From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 12 Jun 2012 14:46:10 +0530
Subject: [PATCH] dmaengine: at_hdmac: trivial: fix comment in header
In-Reply-To: <1339490695-28796-1-git-send-email-nicolas.ferre@atmel.com>
References: <1339490695-28796-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1339492570.1927.1636.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 10:44 +0200, Nicolas Ferre wrote:
> Not all Atmel SoCs were pointed out in header comment which was bringing
> confusion. Remove the truncated list of supported devices, replace by the
> only one that is not supported.
> 
> Reported-by: Elen Song <elen.song@atmel.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/dma/at_hdmac.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7292aa8..bb16013 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -9,10 +9,9 @@
>   * (at your option) any later version.
>   *
>   *
> - * This supports the Atmel AHB DMA Controller,
> - *
> - * The driver has currently been tested with the Atmel AT91SAM9RL
> - * and AT91SAM9G45 series.
> + * This supports the Atmel AHB DMA Controller found in several Atmel SoCs.
> + * The only Atmel DMA Controller that is not covered by this driver is the one
> + * found on AT91SAM9263.
>   */
>  
>  #include <linux/clk.h>
Applied thanks

-- 
~Vinod
