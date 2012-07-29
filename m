From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:31:06 +0100
Subject: [PATCH 01/18] Documentation: Describe the ux500 realated audio
 related DT nodes
In-Reply-To: <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729203106.GD4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:45:45PM +0100, Lee Jones wrote:

> +++ b/Documentation/devicetree/bindings/sound/ux500.txt
> @@ -0,0 +1,62 @@
> +* ux500 Audio Driver and ab8500 Audio CODEC
> +
> +Required properties:
> + - compatible:
> +   - Machine Driver : "stericsson,snd-soc-mop500"
> +   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
> +   - DMA (platform) : "stericsson,ux500-pcm"
> +   - Audio CODEC    : "stericsson,ab8500-codec"

What is this a binding document for?  It looks like the binding for a
machine driver...

> +Optional properties:
> + - reg              : Physical base address and length of the device's registers.
> + - interrupts       : The interrupt outputs from the device.
> + - interrupt-parent : The parent interrupt controller.
> + - <name>-supply    : Phandle to the regulator <name> supply

...but these don't look anything like machine driver properties.
