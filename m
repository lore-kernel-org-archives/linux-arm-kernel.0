From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:55:25 +0100
Subject: [PATCH 1/7] S3C64XX DMA: struct s3c64xx_dma_buff debugged
In-Reply-To: <1253008878-7490-1-git-send-email-jassi.brar@samsung.com>
References: <1253008878-7490-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915235525.GD13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:18PM +0900, Jassi wrote:
> 'struct pl080s_lli' should be the member of struct s3c64xx_dma_buff
> rather than 'struct pl080_lli'.
> Corrected the typo mistake.

applied to next-s3c64xx-fixes, with some edits to the description.
 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/include/plat/dma-plat.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> index 0c30dd9..8f76a1e 100644
> --- a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> +++ b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
> @@ -26,7 +26,7 @@ struct s3c64xx_dma_buff {
>  	struct s3c64xx_dma_buff *next;
>  
>  	void			*pw;
> -	struct pl080_lli	*lli;
> +	struct pl080s_lli	*lli;
>  	dma_addr_t		 lli_dma;
>  };
>  
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
