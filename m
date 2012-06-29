From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 09:20:06 +0800
Subject: [PATCH] ARM: imx28: Add Power LED to the crystalfontz CFA-10036
 board
In-Reply-To: <1340898193-14821-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340898193-14821-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120629012004.GD23422@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please use something like "ARM: dts: cfa10036: ..." as subject prefix.

On Thu, Jun 28, 2012 at 05:43:13PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
Drop this new line.

Regards,
Shawn

> Cc: Brian Lilly <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/cfa10036.dts |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/cfa10036.dts
> index 28b9326..c03a577 100644
> --- a/arch/arm/boot/dts/cfa10036.dts
> +++ b/arch/arm/boot/dts/cfa10036.dts
> @@ -40,4 +40,13 @@
>  			};
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		power {
> +			gpios = <&gpio3 4 1>;
> +			default-state = "on";
> +		};
> +	};
>  };
> -- 
> 1.7.9.5
> 
