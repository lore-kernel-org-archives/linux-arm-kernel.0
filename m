From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Aug 2015 10:36:10 +0800
Subject: [GIT PULL] i.MX clock updates for 4.2
In-Reply-To: <20150811183425.GL2839@codeaurora.org>
References: <20150811085921.GB10035@tiger> <20150811174657.2416.1270@quantum>
 <20150811183425.GL2839@codeaurora.org>
Message-ID: <20150812023609.GD10035@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 11:34:25AM -0700, Stephen Boyd wrote:
> Yes. We would have found this unused include too. I'll apply this
> after we merge it into clk-next.

Thanks Stephen for the fixup.  I will make sure that i.MX clock patches
get Cc'd to you and Mike.

Shawn

> 
> ----8<----
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] clk: imx: Remove unused clkdev.h include
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/imx/clk-imx6ul.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index aaa36650695f..c498f558e942 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -11,7 +11,6 @@
>  
>  #include <dt-bindings/clock/imx6ul-clock.h>
>  #include <linux/clk.h>
> -#include <linux/clkdev.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
