From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 14:44:55 +0800
Subject: [PATCH] ARM: dts: imx6dl-wandboard: Add USB Host support
In-Reply-To: <1365376426-13919-1-git-send-email-festevam@gmail.com>
References: <1365376426-13919-1-git-send-email-festevam@gmail.com>
Message-ID: <20130408064452.GF5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 08:13:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add USB Host1 port support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl-wandboard.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
> index d3ea90a..735911b 100644
> --- a/arch/arm/boot/dts/imx6dl-wandboard.dts
> +++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
> @@ -38,3 +38,7 @@
>  	pinctrl-0 = <&pinctrl_usdhc3_2>;
>  	status = "okay";
>  };
> +
> +&usbh1 {
> +	status = "okay";
> +};

Applied, but moved the node before usdhc3 to have them sorted in
alphabet.

Shawn
