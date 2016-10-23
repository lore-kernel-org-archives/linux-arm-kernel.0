From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 23 Oct 2016 21:01:43 +0800
Subject: [PATCH 1/4] ARM: dts: mxs: Add new M28EVK manufacturer compat
In-Reply-To: <20160919214044.9615-1-marex@denx.de>
References: <20160919214044.9615-1-marex@denx.de>
Message-ID: <20161023130143.GT30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 11:40:41PM +0200, Marek Vasut wrote:
> The board is now manufactured by Aries Embedded GmbH, update compat string.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm/boot/dts/imx28-m28.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx28-m28evk.dts | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
> index 214bb15..a69856e 100644
> --- a/arch/arm/boot/dts/imx28-m28.dtsi
> +++ b/arch/arm/boot/dts/imx28-m28.dtsi
> @@ -12,8 +12,8 @@
>  #include "imx28.dtsi"
>  
>  / {
> -	model = "DENX M28";
> -	compatible = "denx,m28", "fsl,imx28";
> +	model = "Aries/DENX M28";
> +	compatible = "aries,m28", "denx,m28", "fsl,imx28";

Do we have an entry for Aries Embedded GmbH in vendor-prefixes.txt?

Shawn

>  
>  	memory {
>  		reg = <0x40000000 0x08000000>;
> diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
> index 8d04e57..dbfb8aa 100644
> --- a/arch/arm/boot/dts/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> @@ -13,8 +13,8 @@
>  #include "imx28-m28.dtsi"
>  
>  / {
> -	model = "DENX M28EVK";
> -	compatible = "denx,m28evk", "fsl,imx28";
> +	model = "Aries/DENX M28EVK";
> +	compatible = "aries,m28evk", "denx,m28evk", "fsl,imx28";
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
