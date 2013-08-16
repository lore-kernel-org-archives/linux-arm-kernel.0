From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Aug 2013 15:25:38 +0800
Subject: [PATCH RESEND] ARM: dts: vf610-twr: enable i2c0 device
In-Reply-To: <1376629339-4647-1-git-send-email-b35083@freescale.com>
References: <1376629339-4647-1-git-send-email-b35083@freescale.com>
Message-ID: <20130816072536.GA16889@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 01:02:19PM +0800, Jingchang Lu wrote:
> enable i2c0 device on Vybrid VF610 Tower Board
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Applied, thanks.

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
