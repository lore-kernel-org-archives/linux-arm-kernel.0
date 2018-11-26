From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Nov 2018 21:46:08 +0100
Subject: [PATCH v3 2/6] ARM: dtsi: add pwm node for sun8i R40.
In-Reply-To: <20181125161941.GA5305@arx-s1>
References: <20181125161941.GA5305@arx-s1>
Message-ID: <20181126204608.3dpwygx5owbbszdd@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 12:19:41AM +0800, Hao Zhang wrote:
> This patch adds pwm node for sun8i R40.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 6f4c9ca..cc05b2c 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -317,6 +317,7 @@
>  			clock-names = "hosc", "losc";
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> +

This added line is unrelated (and wrong).

>  		};

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
