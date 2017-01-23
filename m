From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 10:50:18 -0600
Subject: [PATCH 04/18] ARM64: dts: meson-gxbb-p20x: Fix Wifi node name
In-Reply-To: <20170120222118.21476-5-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-5-afaerber@suse.de>
Message-ID: <20170123165018.w4jkyckyrltfyhz3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 11:21:04PM +0100, Andreas F?rber wrote:
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

wifi at 1

>  		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  	};
> -- 
> 2.10.2
> 
