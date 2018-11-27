From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 08:52:26 +0100
Subject: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
In-Reply-To: <20181125161859.GA5277@arx-s1>
References: <20181125161859.GA5277@arx-s1>
Message-ID: <20181127075226.qo3mv3o6etqdjaop@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.

You didn't describe those names in that document.

You seem to have used mux-0 and mux-1 for the clock names. I guess we
don't have to use a name there, we can simply use the position to find
out (as long as it's documented in the binding)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
