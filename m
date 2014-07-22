From: varkabhadram@gmail.com (Varka Bhadram)
Date: Tue, 22 Jul 2014 20:02:53 +0530
Subject: [PATCH v4 02/11] mfd: add documentation for atmel-hlcdc DT
 bindings
In-Reply-To: <1406034695-15534-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <1406034695-15534-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53CE7615.4070001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 22 July 2014 06:41 PM, Boris BREZILLON wrote:
> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
> family or sama5d3 family) exposes 2 subdevices:
> - a display controller (controlled by a DRM driver)
> - a PWM chip
>
> This patch adds documentation for atmel-hlcdc DT bindings.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>   .../devicetree/bindings/mfd/atmel-hlcdc.txt        | 50 ++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> new file mode 100644
> index 0000000..e9cc1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> @@ -0,0 +1,50 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
> +
> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,sama5d3-hlcdc"
> + - reg: base address and size of the HLCDC device registers.
> + - clock-names: the name of the 3 clocks requested by the HLCDC device.
> +   Should contain "periph_clk", "sys_clk" and "slow_clk".
> + - clocks: should contain the 3 clocks requested by the HLCDC device.
> +

These bindings not clearly readable. It would be readable if

Required properties:
  - compatible	: value should be one of the following:"atmel,sama5d3-hlcdc"
  - reg		: base address and size of the HLCDC device registers.
  - clock-names	: the name of the 3 clocks requested by the HLCDC device.
		  Should contain "periph_clk", "sys_clk" and "slow_clk".
  - clocks	: should contain the 3 clocks requested by the HLCDC device.

......


-- 
Regards,
Varka Bhadram
