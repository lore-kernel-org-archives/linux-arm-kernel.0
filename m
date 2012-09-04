From: mturquette@ti.com (Mike Turquette)
Date: Tue, 04 Sep 2012 16:07:15 -0700
Subject: [PATCH] clk: versatile: make config option boolean
In-Reply-To: <1346348340-19020-1-git-send-email-linus.walleij@linaro.org>
References: <1346348340-19020-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120904230715.31162.53150@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-08-30 10:39:00)
> There is no choice to have the RealView clocks as module for sure,
> so turn this config option into a boolean.
> 
> Reported-by: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the fix.  Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 89b726d..df33b8e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -41,7 +41,7 @@ config COMMON_CLK_WM831X
>           PMICs from Wolfson Microlectronics.
>  
>  config COMMON_CLK_VERSATILE
> -       tristate "Clock driver for ARM Reference designs"
> +       bool "Clock driver for ARM Reference designs"
>         depends on ARCH_INTEGRATOR || ARCH_REALVIEW
>         ---help---
>            Supports clocking on ARM Reference designs Integrator/AP,
> -- 
> 1.7.7.6
