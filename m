From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:41 +0200
Subject: [PATCH v2 03/18] arm64: dts: meson-gxbb-vega-s95: Fix Wifi node
 name
In-Reply-To: <20170513143337.14278-4-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-4-afaerber@suse.de>
Message-ID: <4eeeb154-7349-9e34-8cd8-282b7ea25a05@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> bcrmf -> brcmf -> wifi
> 
> Fixes: ab5b24fdd2d5 ("ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes")
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Renamed node brmcf -> wifi (Rob)
>  
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index aefa66dff72d..f4bfee8e2e08 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -186,7 +186,7 @@
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&vcc_1v8>;
>  
> -	brcmf: bcrmf at 1 {
> +	brcmf: wifi at 1 {
>  		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  	};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
