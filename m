From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 09:58:44 +0800
Subject: [PATCH] ARM: imx: apf51: add nfc support
In-Reply-To: <1368699931-9977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1368699931-9977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130517015842.GD3893@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 12:25:31PM +0200, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx51-apf51.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
> index 2bcf698..8f7f9ac 100644
> --- a/arch/arm/boot/dts/imx51-apf51.dts
> +++ b/arch/arm/boot/dts/imx51-apf51.dts
> @@ -45,6 +45,13 @@
>  	status = "okay";
>  };
>  
> +&nfc {
> +	nand-bus-width = <8>;
> +	nand-ecc-mode = "hw";
> +	nand-on-flash-bbt;
> +	status = "okay";
> +};
> +
>  &uart3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart3_2>;
> -- 
> 1.8.1.5
> 
