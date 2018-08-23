From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 23 Aug 2018 08:52:58 +0200
Subject: [PATCH] ARM: dts: imx6ull: correct machine model name
In-Reply-To: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,


Am 23.08.2018 um 08:30 schrieb Anson Huang:
> i.MX6ULL is a lite version of i.MX6UL, its full name
> is i.MX6 UltraLiteLite, NOT UlltraLite.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> index 30ef603..0ba6454 100644
> --- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> @@ -45,7 +45,7 @@
>  #include "imx6ul-14x14-evk.dtsi"
>  
>  / {
> -	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
> +	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
>  	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
>  };
>  

looks good, but this compatible should be documented in
Documentation/devicetree/bindings/arm/fsl.txt (should be a separate patch).

Regards
Stefan
