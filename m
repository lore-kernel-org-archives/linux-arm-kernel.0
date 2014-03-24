From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 24 Mar 2014 10:17:42 +0800
Subject: [PATCH RESEND] ARM: dts: imx25-pdk: Add USB Host1 support
In-Reply-To: <1395004160-22732-1-git-send-email-festevam@gmail.com>
References: <1395004160-22732-1-git-send-email-festevam@gmail.com>
Message-ID: <20140324021740.GB4006@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 06:09:20PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx25-pdk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
> index ebaf48d..c608942 100644
> --- a/arch/arm/boot/dts/imx25-pdk.dts
> +++ b/arch/arm/boot/dts/imx25-pdk.dts
> @@ -243,3 +243,9 @@
>  	fsl,uart-has-rtscts;
>  	status = "okay";
>  };
> +
> +&usbhost1 {
> +	phy_type = "serial";
> +	dr_mode = "host";
> +	status = "okay";
> +};
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
