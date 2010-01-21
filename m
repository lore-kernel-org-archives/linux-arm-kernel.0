From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Jan 2010 01:43:58 +0000
Subject: [PATCH] ARM: S3C64XX: Fix typo in s3c-hsotg platform data
In-Reply-To: <b2e8f9f71001201637ua278aa2v56c313d605aa7d13@mail.gmail.com>
References: <b2e8f9f71001201637ua278aa2v56c313d605aa7d13@mail.gmail.com>
Message-ID: <20100121014358.GX10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 01:37:28AM +0100, Maurus Cuelenaere wrote:
> ARM: S3C64XX: Fix typo in s3c-hsotg platform data

applied to next-samsung-s3c64xx2, will merge into next-samsung.
 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/plat-s3c/include/plat/udc-hs.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/include/plat/udc-hs.h
> b/arch/arm/plat-s3c/include/plat/udc-hs.h
> index dd04db0..a22a4f2 100644
> --- a/arch/arm/plat-s3c/include/plat/udc-hs.h
> +++ b/arch/arm/plat-s3c/include/plat/udc-hs.h
> @@ -12,7 +12,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -enum s3c_hostg_dmamode {
> +enum s3c_hsotg_dmamode {
>  	S3C_HSOTG_DMA_NONE,	/* do not use DMA at-all */
>  	S3C_HSOTG_DMA_ONLY,	/* always use DMA */
>  	S3C_HSOTG_DMA_DRV,	/* DMA is chosen by driver */
> @@ -24,6 +24,6 @@ enum s3c_hostg_dmamode {
>   * @is_osc: The clock source is an oscillator, not a crystal
>   */
>  struct s3c_hsotg_plat {
> -	enum s3c_hostg_dmamode	dma;
> +	enum s3c_hsotg_dmamode	dma;
>  	unsigned int		is_osc : 1;
>  };
> -- 
> 1.6.6

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
