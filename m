From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 18 Mar 2016 11:34:40 +0100
Subject: [PATCH 3/3] ARM: at91/dt: sama5d2: add chipid node
In-Reply-To: <1458285681-25684-3-git-send-email-ludovic.desroches@atmel.com>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
 <1458285681-25684-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160318103440.GC2531@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2016 at 08:21:21 +0100, Ludovic Desroches wrote :
> Add node for chipid device in order to have access to the CIDR and EXID
> values.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 78996bd..173e3d7 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1193,6 +1193,11 @@
>  				clock-names = "tdes_clk";
>  				status = "okay";
>  			};
> +
> +			chipid at fc069000 {
> +				compatible = "atmel,sama5d2-chipid";
> +				reg = <0xfc069000 0x8>;
> +			};
>  		};
>  	};
>  };
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
