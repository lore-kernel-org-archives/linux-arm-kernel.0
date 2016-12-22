From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 22 Dec 2016 20:11:04 +0100
Subject: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
In-Reply-To: <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 22, 2016 at 02:35:02PM +0100, M'boumba Cedric Madianga wrote:
> @@ -337,6 +350,16 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			i2c1_pins_b: i2c1 at 0 {
> +				pins1 {
> +					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
> +					drive-open-drain;
> +				};
> +				pins2 {
> +					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
> +				};

the second doesn't need the open-drain property? Why?

> +			};
>  		};

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
