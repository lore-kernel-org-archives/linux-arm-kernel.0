From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Mar 2015 11:53:14 +0000
Subject: [PATCH v5 04/12] mfd: axp20x: update DT bindings with AXP22x
 compatibles
In-Reply-To: <1425988764-23618-5-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-5-git-send-email-wens@csie.org>
Message-ID: <20150323115314.GB24422@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Mar 2015, Chen-Yu Tsai wrote:

> Add AXP221 to the list of supported devices.
> 
> Also replace any mention of AXP20x in the document with a
> generic "PMIC".
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

For my own reference:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 98685f291a72..3914a3f91ff6 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -1,15 +1,16 @@
> -AXP202/AXP209 device tree bindings
> +AXP family PMIC device tree bindings
>  
>  The axp20x family current members :
>  axp202 (X-Powers)
>  axp209 (X-Powers)
> +axp221 (X-Powers)
>  
>  Required properties:
> -- compatible: "x-powers,axp202" or "x-powers,axp209"
> +- compatible: "x-powers,axp202", "x-powers,axp209", "x-powers,axp221"
>  - reg: The I2C slave address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> -- interrupt-controller: axp20x has its own internal IRQs
> +- interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>  
>  Optional properties:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
