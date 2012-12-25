From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Dec 2012 19:05:44 +0800
Subject: [PATCH 1/2] ARM: dts: imx27-3ds: Rename it to imx27-pdk
In-Reply-To: <1356190716-21254-1-git-send-email-festevam@gmail.com>
References: <1356190716-21254-1-git-send-email-festevam@gmail.com>
Message-ID: <20121225110541.GA14088@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 22, 2012 at 01:38:34PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx27-pdk is the name found on Freescale website, so use it instead of 3ds.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} (85%)
> 
> diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-pdk.dts
> similarity index 85%
> rename from arch/arm/boot/dts/imx27-3ds.dts
> rename to arch/arm/boot/dts/imx27-pdk.dts
> index fa04c7b..860b6f2 100644
> --- a/arch/arm/boot/dts/imx27-3ds.dts
> +++ b/arch/arm/boot/dts/imx27-pdk.dts
> @@ -13,8 +13,8 @@
>  /include/ "imx27.dtsi"
>  
>  / {
> -	model = "mx27_3ds";
> -	compatible = "freescale,imx27-3ds", "fsl,imx27";
> +	model = "Freescale i.MX27 Product Development Kit";
> +	compatible = "freescale,imx27-pdk", "fsl,imx27";

Since you are there, you may want to change it to:

	compatible = "fsl,imx27-pdk", "fsl,imx27";

Shawn

>  
>  	memory {
>  		reg = <0x0 0x0>;
> -- 
> 1.7.9.5
> 
