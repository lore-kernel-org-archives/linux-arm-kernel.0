From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 22:58:49 +0800
Subject: [PATCH] arm: dts: imx6q-ba16: Remove unused vqmmc-supply
In-Reply-To: <1459194163-8540-1-git-send-email-akshay.bhat@timesys.com>
References: <1459194163-8540-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160411145849.GA15949@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 03:42:43PM -0400, Akshay Bhat wrote:
> The vqmmc supply is not connected to bio supply on the BA16 module.
> Remove the same.

'the same'?

Also, please use 'ARM: ' than lowercase for patch subject.

Shawn

> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
>  arch/arm/boot/dts/imx6q-ba16.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
> index 8f6e603..96701a3 100644
> --- a/arch/arm/boot/dts/imx6q-ba16.dtsi
> +++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
> @@ -390,7 +390,6 @@
>  	pinctrl-0 = <&pinctrl_usdhc3 &pinctrl_usdhc3_reset>;
>  	bus-width = <8>;
>  	vmmc-supply = <&vdd_bperi>;
> -	vqmmc-supply = <&vdd_bio>;
>  	non-removable;
>  	keep-power-in-suspend;
>  	status = "okay";
> -- 
> 2.7.4
> 
> 
