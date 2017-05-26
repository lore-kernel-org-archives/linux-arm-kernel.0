From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 May 2017 20:52:14 +0200
Subject: [PATCH 1/5] dts: gpio_atmel: adapt binding doc to reality
In-Reply-To: <20170526180609.2699-1-uwe@kleine-koenig.org>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
Message-ID: <20170526185214.GB20946@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +- interrupt-controller: Marks the device node as a GPIO controller.

Interrupt controller, not GPIO controller.

> +- #interrupt-cells: Should be two. The first cell is the pin number and the
> +  second cell is used to specify irq type flags:
> +      1 = low-to-high edge triggered.
> +      2 = high-to-low edge triggered.
> +      4 = active high level-sensitive.
> +      8 = active low level-sensitive.

Maybe just reference interrupts.txt?

      Andrew
