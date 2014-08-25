From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Aug 2014 09:01:57 -0700
Subject: [PATCH v5 6/7] am33xx: define syscon control module device node
In-Reply-To: <1408947828-22316-7-git-send-email-mpa@pengutronix.de>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-7-git-send-email-mpa@pengutronix.de>
Message-ID: <20140825160156.GH17254@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Markus Pargmann <mpa@pengutronix.de> [140824 23:24]:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 3a0a161342ba..25e38b6ac376 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -132,6 +132,11 @@
>  			};
>  		};
>  
> +		cm: syscon at 44e10000 {
> +			compatible = "ti,am33xx-controlmodule", "syscon";
> +			reg = <0x44e10000 0x800>;
> +		};
> +
>  		intc: interrupt-controller at 48200000 {
>  			compatible = "ti,omap2-intc";
>  			interrupt-controller;
> -- 
> 2.1.0.rc1
> 
