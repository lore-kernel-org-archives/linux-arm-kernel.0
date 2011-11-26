From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 26 Nov 2011 08:51:30 +0800
Subject: [PATCH v3 1/5] clk: Kconfig: add entry for HAVE_CLK_PREPARE
In-Reply-To: <1321926047-14211-2-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-2-git-send-email-mturquette@linaro.org>
Message-ID: <20111126005128.GA19025@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 05:40:43PM -0800, Mike Turquette wrote:
> The common clk framework provides clk_prepare and clk_unprepare
> implementations.  Create an entry for HAVE_CLK_PREPARE so that
> GENERIC_CLK can select it.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

>  drivers/clk/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3530927..7a9899bd 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
>  
>  config HAVE_MACH_CLKDEV
>  	bool
> +
> +config HAVE_CLK_PREPARE
> +	bool
> -- 
> 1.7.4.1
