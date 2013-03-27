From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Mar 2013 08:44:40 -0700
Subject: [PATCH] clk: zynq: Add missing zynq clk header
In-Reply-To: <1364395506-28250-1-git-send-email-michal.simek@xilinx.com>
References: <1364395506-28250-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <20130327154440.4014.62677@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2013-03-27 07:45:06)
> Include zynq clk header where init function is declared.
> 
> It removes this sparse warning:
> drivers/clk/clk-zynq.c:373:13: warning: symbol
> 'xilinx_zynq_clocks_init' was not declared. Should it be static?
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks for the fix.  Pulled into clk-next.

Regards,
Mike

> ---
>  drivers/clk/clk-zynq.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-zynq.c b/drivers/clk/clk-zynq.c
> index b14a25f..3206297 100644
> --- a/drivers/clk/clk-zynq.c
> +++ b/drivers/clk/clk-zynq.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/clk-provider.h>
> +#include <linux/clk/zynq.h>
>  
>  static void __iomem *slcr_base;
>  
> -- 
> 1.7.9.7
