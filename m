From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 10:40:49 +0800
Subject: [PATCH] arm: mxs: Fix MMC WP pin being inverted
In-Reply-To: <1346811082-27295-1-git-send-email-marex@denx.de>
References: <1346811082-27295-1-git-send-email-marex@denx.de>
Message-ID: <20120905024046.GR2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please resend with subject "arm: " changing to "ARM: ", or even better
the one below.

  ARM: dts: m28evk: ...

On Wed, Sep 05, 2012 at 04:11:22AM +0200, Marek Vasut wrote:
> The MMC WP is active high on the m28evk, fix this.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28-m28evk.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
> index 845bb42..10868f1 100644
> --- a/arch/arm/boot/dts/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> @@ -63,7 +63,7 @@
>  					     &mmc0_cd_cfg
>  					     &mmc0_sck_cfg>;
>  				bus-width = <8>;
> -				wp-gpios = <&gpio3 10 1>;
> +				wp-gpios = <&gpio3 10 0>;
>  				vmmc-supply = <&reg_vddio_sd0>;
>  				status = "okay";
>  			};
> -- 
> 1.7.10.4
> 

-- 
Regards,
Shawn
