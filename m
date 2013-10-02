From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 12:22:21 -0400
Subject: [PATCH] clk: armada-370: fix tclk frequencies
In-Reply-To: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
References: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20131002162221.GN31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

On Wed, Oct 02, 2013 at 05:56:58PM +0200, Simon Guinot wrote:
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>

Could you elaborate on this?  What symptom did you notice?  How did this
fix it?  When was the regression introduced?

thx,

Jason.

> ---
>  drivers/clk/mvebu/armada-370.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
> index fc777bd..81a202d 100644
> --- a/drivers/clk/mvebu/armada-370.c
> +++ b/drivers/clk/mvebu/armada-370.c
> @@ -39,8 +39,8 @@ static const struct coreclk_ratio a370_coreclk_ratios[] __initconst = {
>  };
>  
>  static const u32 a370_tclk_freqs[] __initconst = {
> -	16600000,
> -	20000000,
> +	166000000,
> +	200000000,
>  };
>  
>  static u32 __init a370_get_tclk_freq(void __iomem *sar)
> -- 
> 1.7.10.4
> 
