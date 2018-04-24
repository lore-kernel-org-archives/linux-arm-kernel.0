From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 24 Apr 2018 18:04:07 +0200
Subject: [PATCH 1/5] ARM: dts: imx53-ppd: Remove unnecessary
 #address/#size-cells
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <20180424160407.rekalmti4cr7rbru@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 23, 2018 at 04:50:29PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unnecessary #address-cells/#size-cells to fix the following
> DTC warnings:
> 
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /power-gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /touch-lock-key: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/boot/dts/imx53-ppd.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
> index d5628af..c394857 100644
> --- a/arch/arm/boot/dts/imx53-ppd.dts
> +++ b/arch/arm/boot/dts/imx53-ppd.dts
> @@ -180,8 +180,6 @@
>  
>  	power-gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  
>  		power-button {
>  			label = "Power button";
> @@ -192,8 +190,6 @@
>  
>  	touch-lock-key {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  
>  		touch-lock-button {
>  			label = "Touch lock button";
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/ed1c689b/attachment.sig>
