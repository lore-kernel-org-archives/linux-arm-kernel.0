From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Jan 2014 15:37:56 +0800
Subject: [PATCH 2/4] ARM: dts: cm-fx6: add SATA support
In-Reply-To: <1390320812-25100-3-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
 <1390320812-25100-3-git-send-email-grinberg@compulab.co.il>
Message-ID: <20140127073754.GB4765@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 06:13:30PM +0200, Igor Grinberg wrote:
> Enable SATA on cm-fx6.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index 94cc6b5..07f90a5 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -69,3 +69,7 @@
>  	pinctrl-0 = <&pinctrl_uart4>;
>  	status = "okay";
>  };
> +
> +&sata {
> +	status = "okay";
> +};

Please sort these labeled nodes alphabetically.

Shawn

> -- 
> 1.8.3.2
> 
