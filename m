From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 12 Mar 2017 13:49:32 -0700
Subject: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
In-Reply-To: <20170311172527.16368-5-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-5-krzk@kernel.org>
Message-ID: <0d8ee3a3-b8df-854a-4443-5b87babc00e9@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
> boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/s3c64xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
> index 0ccb414cd268..6caec5f27d38 100644
> --- a/arch/arm/boot/dts/s3c64xx.dtsi
> +++ b/arch/arm/boot/dts/s3c64xx.dtsi
> @@ -100,7 +100,6 @@
>  			interrupts = <26>;
>  			clock-names = "watchdog";
>  			clocks = <&clocks PCLK_WDT>;
> -			status = "disabled";
>  		};
>
>  		i2c0: i2c at 7f004000 {
>
