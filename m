From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 13 Jul 2015 08:24:39 +0100
Subject: [PATCH v3 1/2] ARM: dts: Add binding documentation for AXP152 PMIC
In-Reply-To: <1436619596-11823-1-git-send-email-hdegoede@redhat.com>
References: <1436619596-11823-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150713072439.GG12199@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jul 2015, Hans de Goede wrote:

> Add devicetree binding documentation for the AXP152 PMIC, this is a
> stripped down version of the AXP202 PMIC with the battery charging
> function removed.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -New patch in v2 of this series
> Changes in v3:
> -Added Michal Suchanek's S-o-b (with his permission)
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 753f14f..4181122 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -1,12 +1,14 @@
>  AXP family PMIC device tree bindings
>  
>  The axp20x family current members :
> +axp152 (X-Powers)
>  axp202 (X-Powers)
>  axp209 (X-Powers)
>  axp221 (X-Powers)
>  
>  Required properties:
> -- compatible: "x-powers,axp202", "x-powers,axp209", "x-powers,axp221"
> +- compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> +	      "x-powers,axp221"
>  - reg: The I2C slave address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
