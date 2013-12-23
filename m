From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 23 Dec 2013 13:33:45 -0300
Subject: [PATCH 3/4] pinctrl: sunxi: Add Allwinner A20 clock output pin
 functions
In-Reply-To: <1387787827-11341-4-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <1387787827-11341-4-git-send-email-wens@csie.org>
Message-ID: <52B865E9.4040800@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 23/12/13 05:37, Chen-Yu Tsai escribi?:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

A commit description would be nice :) What are these outputs used for?

>   drivers/pinctrl/pinctrl-sunxi-pins.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-sunxi-pins.h b/drivers/pinctrl/pinctrl-sunxi-pins.h
> index 2c7446a..567bc44 100644
> --- a/drivers/pinctrl/pinctrl-sunxi-pins.h
> +++ b/drivers/pinctrl/pinctrl-sunxi-pins.h
> @@ -3774,12 +3774,14 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
>   		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
>   		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
> +		  SUNXI_FUNCTION(0x4, "clk_out_a"),

I would add a /* comment */ here and below too, to keep in line with the 
rest of the file, but this is just me nitpicking :)

>   		  SUNXI_FUNCTION_IRQ(0x5, 24)),		/* EINT24 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI13,
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
>   		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
>   		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
> +		  SUNXI_FUNCTION(0x4, "clk_out_b"),
>   		  SUNXI_FUNCTION_IRQ(0x5, 25)),		/* EINT25 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI14,
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>

Cheers!

Emilio
