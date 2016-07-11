From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 11 Jul 2016 14:36:44 -0700
Subject: [PATCH 2/2] clk: sunxi-ng: h3: Fix Kconfig symbol typo
In-Reply-To: <20160711203448.18062-2-maxime.ripard@free-electrons.com>
References: <20160711203448.18062-1-maxime.ripard@free-electrons.com>
 <20160711203448.18062-2-maxime.ripard@free-electrons.com>
Message-ID: <146827300441.73491.7304040389172798052@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2016-07-11 13:34:48)
> The Kconfig symbol for the sun8i SoC family was mistyped. Fix that.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

Regards,
Mike

> ---
>  drivers/clk/sunxi-ng/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 41e53e8d4d41..2afcbd39e41e 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -60,6 +60,6 @@ config SUN8I_H3_CCU
>         select SUNXI_CCU_NM
>         select SUNXI_CCU_MP
>         select SUNXI_CCU_PHASE
> -       default ARCH_SUN8I
> +       default MACH_SUN8I
>  
>  endif
> -- 
> 2.9.0
> 
