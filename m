From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 1 Aug 2017 14:09:28 +0200
Subject: [PATCH v3 1/2] clk: meson: gxbb: Add sd_emmc clk0 clkids
In-Reply-To: <20170731115603.29720-2-jbrunet@baylibre.com>
References: <20170731115603.29720-1-jbrunet@baylibre.com>
 <20170731115603.29720-2-jbrunet@baylibre.com>
Message-ID: <ddf63956-781d-670b-366e-712445307e60@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2017 01:56 PM, Jerome Brunet wrote:
> Add the clkids for the clocks feeding the input0 of the mmc controllers
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.h              | 10 ++++++++--
>  include/dt-bindings/clock/gxbb-clkc.h |  3 +++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 2c8986d3232c..5b1d4b374d1c 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -184,8 +184,14 @@
>  #define CLKID_CTS_MCLK_I958_DIV	  112
>  #define CLKID_32K_CLK_SEL	  115
>  #define CLKID_32K_CLK_DIV	  116
> -
> -#define NR_CLKS			  117
> +#define CLKID_SD_EMMC_A_CLK0_SEL  117
> +#define CLKID_SD_EMMC_A_CLK0_DIV  118
> +#define CLKID_SD_EMMC_B_CLK0_SEL  120
> +#define CLKID_SD_EMMC_B_CLK0_DIV  121
> +#define CLKID_SD_EMMC_C_CLK0_SEL  123
> +#define CLKID_SD_EMMC_C_CLK0_DIV  124
> +
> +#define NR_CLKS			  126
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/gxbb-clkc.h>
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index e07fea011ebd..c04a76d8facf 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -110,5 +110,8 @@
>  #define CLKID_CTS_MCLK_I958	110
>  #define CLKID_CTS_I958		113
>  #define CLKID_32K_CLK		114
> +#define CLKID_SD_EMMC_A_CLK0	119
> +#define CLKID_SD_EMMC_B_CLK0	122
> +#define CLKID_SD_EMMC_C_CLK0	125
>  
>  #endif /* __GXBB_CLKC_H */
> 

Applied to clk-meson's next/headers.

Thanks,
Neil
