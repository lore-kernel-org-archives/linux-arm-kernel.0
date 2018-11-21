From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Nov 2018 12:25:21 +0100
Subject: [PATCH] ARM: dts: at91: nattis: initialize the BLON pin as
 output-low early
In-Reply-To: <20181120212036.22497-1-peda@axentia.se>
References: <20181120212036.22497-1-peda@axentia.se>
Message-ID: <20181121112521.GL8367@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2018 21:20:43+0000, Peter Rosin wrote:
> The pwm-backlight driver initializes BLON (the enable gpio) to
> output-high if the gpio is input on probe. Initializing the gpio
> to output-low before the driver probes prevents this action by
> the pwm-backlight driver and gets rid of a nasty blink of full
> backlight with an uninitialized panel.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
