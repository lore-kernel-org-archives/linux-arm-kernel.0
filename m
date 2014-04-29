From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 13:08:12 +0800
Subject: [PATCH] ARM: dts: imx27-phytec-phycard-s-rdk: Remove
 'regulator-always-on'
In-Reply-To: <1398265137-32586-1-git-send-email-festevam@gmail.com>
References: <1398265137-32586-1-git-send-email-festevam@gmail.com>
Message-ID: <20140429050810.GB16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 11:58:57AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no point in using 'regulator-always-on' for a fixed regulator that is 
> not controlled via GPIO.

I've seen such cosmetic change a couple of times, and wouldn't like to
take the patch individually.  If you think it's really a change worth
patching, please do it globally for i.MX dts files.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
> index 3c3964a..3376041 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
> @@ -46,7 +46,6 @@
>  			regulator-name = "3V3";
>  			regulator-min-microvolt = <3300000>;
>  			regulator-max-microvolt = <3300000>;
> -			regulator-always-on;
>  		};
>  	};
>  };
> -- 
> 1.8.3.2
> 
> 
> 
