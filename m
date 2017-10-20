From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Oct 2017 10:09:36 +0200
Subject: [PATCH 7/7] ARM64: dts: meson-gxl: adjust libretech-cc
 gpio-line-names
In-Reply-To: <20170921171604.27675-1-jbrunet@baylibre.com>
References: <20170921171604.27675-1-jbrunet@baylibre.com>
Message-ID: <60881aa5-7249-e7e7-4a3f-64eca2ccd910@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2017 19:16, Jerome Brunet wrote:
> TEST_N gpio has been moved so the gpio-line-names of the cc
> must be adjusted accordingly
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 69ca14ac10fa..3e9b9c8b72f0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -146,7 +146,9 @@
>  			  "7J1 Header Pin12",
>  			  "IR In",
>  			  "9J3 Switch HDMI CEC/7J1 Header Pin11",
> -			  "7J1 Header Pin13";
> +			  "7J1 Header Pin13",
> +			  /* GPIO_TEST_N */
> +			  "7J1 Header Pin15";
>  };
>  
>  &pinctrl_periphs {
> @@ -188,9 +190,7 @@
>  			  "7J1 Header Pin32", "7J1 Header Pin29",
>  			  "7J1 Header Pin31",
>  			  /* Bank GPIOCLK */
> -			  "7J1 Header Pin7", "",
> -			  /* GPIO_TEST_N */
> -			  "7J1 Header Pin15";
> +			  "7J1 Header Pin7", "";
>  };
>  
>  /* SD card */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
