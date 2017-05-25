From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 24 May 2017 17:59:04 -0700
Subject: [PATCH v4 3/3] ARM: socfpga: dtsi: add dw-wdt reset lines
In-Reply-To: <1606b1da6758142628496ae85b15b3f89f0f928d.1495443015.git-series.s.trumtrar@pengutronix.de>
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
 <1606b1da6758142628496ae85b15b3f89f0f928d.1495443015.git-series.s.trumtrar@pengutronix.de>
Message-ID: <b373e06d-ecd9-0c22-5c6c-043bb0e395fa@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2017 01:51 AM, Steffen Trumtrar wrote:
> Add the reset lines to both watchdogs.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/socfpga.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index b2674bdb8e6a..547b2720abf5 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -924,6 +924,7 @@
>   			reg = <0xffd02000 0x1000>;
>   			interrupts = <0 171 4>;
>   			clocks = <&osc1>;
> +			resets = <&rst L4WD0_RESET>;
>   			status = "disabled";
>   		};
>   
> @@ -932,6 +933,7 @@
>   			reg = <0xffd03000 0x1000>;
>   			interrupts = <0 172 4>;
>   			clocks = <&osc1>;
> +			resets = <&rst L4WD1_RESET>;
>   			status = "disabled";
>   		};
>   	};
> 
