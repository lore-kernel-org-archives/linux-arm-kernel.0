From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:56:18 +0100
Subject: [PATCH 07/18] ARM64: dts: meson-gxl-s905x: Comment typo fix
In-Reply-To: <20170120222118.21476-8-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-8-afaerber@suse.de>
Message-ID: <d99a916f-f970-f75f-63e1-d95bc85656a7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> index 08237ee1e362..d49ee3c04dd7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> @@ -47,7 +47,7 @@
>  	compatible = "amlogic,s905x", "amlogic,meson-gxl";
>  };
>  
> -/* S905X Only has access to its internal PHY */
> +/* S905X only has access to its internal PHY */
>  &ethmac {
>  	phy-mode = "rmii";
>  	phy-handle = <&internal_phy>;
> 

Can't hurt

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
