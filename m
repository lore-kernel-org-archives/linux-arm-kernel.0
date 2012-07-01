From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 1 Jul 2012 22:20:00 +0800
Subject: [PATCHv2] ARM: dts: cfa10036: Add Power LED to the CFA-10036 board
In-Reply-To: <1340955569-16513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340955569-16513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120701141958.GC21595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 09:39:29AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>

Applied, thanks.

Regards,
Shawn

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
