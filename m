From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 6 Aug 2015 15:41:34 +0800
Subject: [PATCH] ARM: dts: imx6sx: correct property name for wakeup source
In-Reply-To: <1438783075-15133-1-git-send-email-b20788@freescale.com>
References: <1438783075-15133-1-git-send-email-b20788@freescale.com>
Message-ID: <20150806074134.GA9847@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 09:57:55PM +0800, Anson Huang wrote:
> Commit(def56bb input: snvs_pwrkey: use "wakeup-source"
> as deivce tree property name) replaces the property name
> of "wakeup" with "wakeup-source", update this change
> in i.MX6SX dtsi accordingly.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

For arch/arm/ patches, please remember to copy linux-arm-kernel.

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index e391d63..dc7eaae 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -686,7 +686,7 @@
>  					regmap = <&snvs>;
>  					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>  					linux,keycode = <KEY_POWER>;
> -					wakeup;
> +					wakeup-source;
>  				};
>  			};
>  
> -- 
> 1.9.1
> 
