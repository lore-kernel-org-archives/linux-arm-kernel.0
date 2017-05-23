From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 11:17:22 +0200
Subject: [PATCH v3 1/4] dt-bindings: clock: gxbb: expose UART clocks
In-Reply-To: <20170331165437.26227-2-hgkr.klein@gmail.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
 <20170331165437.26227-2-hgkr.klein@gmail.com>
Message-ID: <95a5e461-a145-b301-564f-150aed2eea91@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Helmut,

On 03/31/2017 06:54 PM, Helmut Klein wrote:
> Expose the clock ids of the three none AO uarts to the dt-bindings
> 
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> ---
>  drivers/clk/meson/gxbb.h              | 6 +++---
>  include/dt-bindings/clock/gxbb-clkc.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 8ee2022ce5d5..1edfaa5fe307 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -194,7 +194,7 @@
>  /* #define CLKID_SAR_ADC */
>  #define CLKID_SMART_CARD	  24
>  #define CLKID_RNG0		  25
> -#define CLKID_UART0		  26
> +/* CLKID_UART0 */
>  #define CLKID_SDHC		  27
>  #define CLKID_STREAM		  28
>  #define CLKID_ASYNC_FIFO	  29
> @@ -216,7 +216,7 @@
>  #define CLKID_ADC		  45
>  #define CLKID_BLKMV		  46
>  #define CLKID_AIU		  47
> -#define CLKID_UART1		  48
> +/* CLKID_UART1 */
>  #define CLKID_G2D		  49
>  /* CLKID_USB0 */
>  /* CLKID_USB1 */
> @@ -236,7 +236,7 @@
>  /* CLKID_USB0_DDR_BRIDGE */
>  #define CLKID_MMC_PCLK		  66
>  #define CLKID_DVIN		  67
> -#define CLKID_UART2		  68
> +/* CLKID_UART2 */
>  /* #define CLKID_SANA */
>  #define CLKID_VPU_INTR		  70
>  #define CLKID_SEC_AHB_AHB3_BRIDGE 71
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index 692846c7941b..7b329df47752 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -15,13 +15,16 @@
>  #define CLKID_SPI		34
>  #define CLKID_I2C		22
>  #define CLKID_SAR_ADC		23
> +#define CLKID_UART0		26
>  #define CLKID_ETH		36
> +#define CLKID_UART1		48
>  #define CLKID_USB0		50
>  #define CLKID_USB1		51
>  #define CLKID_USB		55
>  #define CLKID_HDMI_PCLK		63
>  #define CLKID_USB1_DDR_BRIDGE	64
>  #define CLKID_USB0_DDR_BRIDGE	65
> +#define CLKID_UART2		68
>  #define CLKID_SANA		69
>  #define CLKID_GCLK_VENCI_INT0	77
>  #define CLKID_AO_I2C		93

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I rebased on 4.12-rc1 and applied on next/headers.

Thanks,
Neil
