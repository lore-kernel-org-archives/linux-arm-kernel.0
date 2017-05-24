From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 10:39:26 +0200
Subject: [PATCH 1/3] ARM64: dts: meson-gxl: Fix pinctrl periphs gpio-ranges
In-Reply-To: <1495549311-23660-2-git-send-email-narmstrong@baylibre.com>
References: <1495549311-23660-1-git-send-email-narmstrong@baylibre.com>
 <1495549311-23660-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495615166.14589.2.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-23 at 16:21 +0200, Neil Armstrong wrote:
> The gpio-range was badly added on the GXL dtsi, the AO pin count is 10
> instead of 14.
> 

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> Fixes: 84412e4e857f ("ARM64: dts: meson-gxl: Add gpio-ranges properties")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> ?arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 3efad5f..4871ce5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -244,7 +244,7 @@
> ?			reg-names = "mux", "pull", "pull-enable", "gpio";
> ?			gpio-controller;
> ?			#gpio-cells = <2>;
> -			gpio-ranges = <&pinctrl_periphs 0 14 101>;
> +			gpio-ranges = <&pinctrl_periphs 0 10 101>;
> ?		};
> ?
> ?		emmc_pins: emmc {
