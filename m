From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 19 Jun 2018 11:10:48 +0100
Subject: [PATCH] dt-bindings: Fix unbalanced quotation marks
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Message-ID: <819db945-1f89-93d3-b213-365a9704e100@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/18 15:31, Jonathan Neusch?fer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
> ---
> 
> Should I split this patch so that different parts can go through different trees?
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)

...

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> index 1099fe0788fa..f246ccbf8838 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> @@ -15,7 +15,7 @@ Required properties:
>    include "nvidia,tegra30-ictlr".	
>  - reg : Specifies base physical address and size of the registers.
>    Each controller must be described separately (Tegra20 has 4 of them,
> -  whereas Tegra30 and later have 5"  
> +  whereas Tegra30 and later have 5).
>  - interrupt-controller : Identifies the node as an interrupt controller.
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source. The value must be 3.

For the above Tegra portion ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
