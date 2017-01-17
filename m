From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 17 Jan 2017 08:54:06 -0800
Subject: [PATCH] clk: meson-gxbb: Export HDMI clocks
In-Reply-To: <1484654928-5640-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 17 Jan 2017 13:08:48 +0100")
References: <1484654928-5640-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2d1fl4ogh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Export HDMI clock from internal to dt-bindings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/clk/meson/gxbb.h              | 4 ++--
>  include/dt-bindings/clock/gxbb-clkc.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 0252939..2139e97 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -231,7 +231,7 @@
>  #define CLKID_AHB_DATA_BUS	  60
>  #define CLKID_AHB_CTRL_BUS	  61
>  #define CLKID_HDMI_INTR_SYNC	  62
> -#define CLKID_HDMI_PCLK		  63
> +/* CLKID_HDMI_PCLK */
>  /* CLKID_USB1_DDR_BRIDGE */
>  /* CLKID_USB0_DDR_BRIDGE */
>  #define CLKID_MMC_PCLK		  66
> @@ -245,7 +245,7 @@
>  #define CLKID_VCLK2_VENCI1	  74
>  #define CLKID_VCLK2_VENCP0	  75
>  #define CLKID_VCLK2_VENCP1	  76
> -#define CLKID_GCLK_VENCI_INT0	  77
> +/* CLKID_GCLK_VENCI_INT0 */
>  #define CLKID_GCLK_VENCI_INT	  78
>  #define CLKID_DAC_CLK		  79
>  #define CLKID_AOCLK_GATE	  80
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index baade6f..da1d473 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -18,8 +18,10 @@
>  #define CLKID_USB0		50
>  #define CLKID_USB1		51
>  #define CLKID_USB		55
> +#define CLKID_HDMI_PCLK		63
>  #define CLKID_USB1_DDR_BRIDGE	64
>  #define CLKID_USB0_DDR_BRIDGE	65
> +#define CLKID_GCLK_VENCI_INT0	77
>  #define CLKID_AO_I2C		93
>  #define CLKID_SD_EMMC_A		94
>  #define CLKID_SD_EMMC_B		95
