From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Oct 2016 07:59:54 -0000
Subject: [PATCH] clk: meson-gxbb: Export PWM related clocks for DT
In-Reply-To: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
References: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <147285925618.69079.14195001640916253279@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Neil Armstrong (2016-08-22 05:49:37)
> Add the PWM related clocks in order to be referenced as PWM source
> clocks.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied.

Regards,
Mike

> ---
>  drivers/clk/meson/gxbb.h              | 6 +++---
>  include/dt-bindings/clock/gxbb-clkc.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index a2adf34..523b494 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -170,11 +170,11 @@
>   */
>  #define CLKID_SYS_PLL            0
>  /* CLKID_CPUCLK */
> -#define CLKID_HDMI_PLL           2
> +/* CLKID_HDMI_PLL */
>  #define CLKID_FIXED_PLL                  3
>  #define CLKID_FCLK_DIV2                  4
> -#define CLKID_FCLK_DIV3                  5
> -#define CLKID_FCLK_DIV4                  6
> +/* CLKID_FCLK_DIV3 */
> +/* CLKID_FCLK_DIV4 */
>  #define CLKID_FCLK_DIV5                  7
>  #define CLKID_FCLK_DIV7                  8
>  #define CLKID_GP0_PLL            9
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index f889d80..a5897f3 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -6,6 +6,9 @@
>  #define __GXBB_CLKC_H
>  
>  #define CLKID_CPUCLK           1
> +#define CLKID_HDMI_PLL         2
> +#define CLKID_FCLK_DIV3                5
> +#define CLKID_FCLK_DIV4                6
>  #define CLKID_CLK81            12
>  #define CLKID_ETH              36
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
