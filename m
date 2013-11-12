From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 12 Nov 2013 09:51:56 +0800
Subject: [PATCH] ARM: imx27-apf27dev: Add sdhci support
In-Reply-To: <1384192609-97029-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1384192609-97029-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131112015153.GF11083@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 06:56:49PM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---

Applied, thanks.

>  arch/arm/boot/dts/imx27-apf27dev.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index 47c8c26..7d90877 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -89,3 +89,9 @@
>  &i2c2 {
>  	status = "okay";
>  };
> +
> +&sdhci2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 14 0>;
> +	status = "okay";
> +};
> -- 
> 1.8.3.2
> 
