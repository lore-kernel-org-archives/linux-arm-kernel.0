From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:55:11 +0100
Subject: [PATCH 04/18] ARM64: dts: meson-gxbb-p20x: Fix Wifi node name
In-Reply-To: <20170120222118.21476-5-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-5-afaerber@suse.de>
Message-ID: <c61607a4-8c95-8061-e445-8fb5edeaf648@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> bcrmf -> brcmf
> 
> Fixes: ab3943fe57a2 ("ARM64: dts: meson-gxbb: Add P20x Wifi SDIO support")
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index 4a96e0f6f926..5183c5ce90c6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -193,7 +193,7 @@
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
>  
> -	brcmf: bcrmf at 1 {
> +	brcmf: brcmf at 1 {
>  		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  	};
> 

Good catch !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
