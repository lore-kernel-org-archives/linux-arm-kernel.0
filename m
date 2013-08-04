From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Aug 2013 21:30:47 +0800
Subject: [PATCH RESEND 1/2] ARM: dts: vf610-twr: enable i2c0 device
In-Reply-To: <1375418648-22760-1-git-send-email-b35083@freescale.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
Message-ID: <20130804133045.GG18119@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 12:44:07PM +0800, Jingchang Lu wrote:
> enable i2c0 device on Vybrid VF610 Tower Board
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

I suggest you send me the patch after the driver part gets accepted by
subsystem maintainer.

Shawn

> ---
>  arch/arm/boot/dts/vf610-twr.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index b3905f5..1a58678 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -50,6 +50,13 @@
>  	status = "okay";
>  };
>  
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c0_1>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1_1>;
> -- 
> 1.8.0
> 
> 
