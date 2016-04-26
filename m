From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 22:00:20 +0530
Subject: [PATCH 3/4] dmaengine: pxa_dma: remove duplicate const qualifier
In-Reply-To: <1461577678-29517-3-git-send-email-eric.engestrom@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-3-git-send-email-eric.engestrom@imgtec.com>
Message-ID: <20160426163019.GM2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 10:47:56AM +0100, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
> ---
>  drivers/dma/pxa_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 77c1c44..315901d 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -1321,7 +1321,7 @@ static int pxad_init_phys(struct platform_device *op,
>  	return 0;
>  }
>  
> -static const struct of_device_id const pxad_dt_ids[] = {
> +static const struct of_device_id pxad_dt_ids[] = {
>  	{ .compatible = "marvell,pdma-1.0", },
>  	{}
>  };

Applied, thanks


-- 
~Vinod
