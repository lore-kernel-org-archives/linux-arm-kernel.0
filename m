From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 07 Dec 2016 12:56:49 -0500
Subject: [PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
In-Reply-To: <20161205014237.1689-2-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014237.1689-2-vz@mleia.com>
Message-ID: <1481133409.9248.1.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-12-05 at 03:42 +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> Another added to the description property 'clocks' has a standard meaning
> of a controller supply clock, in the LPC32xx User's Manual the clock is
> denoted as PWM1_CLK or PWM2_CLK clock.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
