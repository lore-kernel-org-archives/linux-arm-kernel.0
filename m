From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 May 2013 16:20:02 +0200
Subject: [PATCH 1/3] dmaengine: at_hdmac/trivial: correct typo in comment
In-Reply-To: <042cac60509755c1340d141315a9a8eb1965438a.1368191734.git.nicolas.ferre@atmel.com>
References: <042cac60509755c1340d141315a9a8eb1965438a.1368191734.git.nicolas.ferre@atmel.com>
Message-ID: <20130510142002.GL3041@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on all

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On 15:19 Fri 10 May     , Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/dma/at_hdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e923cda..cd49420 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1120,7 +1120,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
>  		 */
>  		BUG_ON(!atslave->dma_dev || atslave->dma_dev != atdma->dma_common.dev);
>  
> -		/* if cfg configuration specified take it instad of default */
> +		/* if cfg configuration specified take it instead of default */
>  		if (atslave->cfg)
>  			cfg = atslave->cfg;
>  	}
> -- 
> 1.8.0
> 
