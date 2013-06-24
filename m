From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 21:11:32 +0800
Subject: [PATCH] apf27dev: add rtc ds1374 to the device tree
In-Reply-To: <1371831853-24754-1-git-send-email-tremyfr@yahoo.fr>
References: <1371831853-24754-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <20130624131130.GD30747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:24:13PM +0200, Philippe Reynes wrote:
> 
> Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index 66b8e1c..2a377ca 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -53,6 +53,11 @@
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	status = "okay";
> +
> +	rtc at 68 {
> +		compatible = "dallas,ds1374";
> +		reg = <0x68>;
> +	};
>  };
>  
>  &i2c2 {
> -- 
> 1.7.4.4
> 
