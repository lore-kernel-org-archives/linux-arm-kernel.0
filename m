From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Apr 2017 13:08:15 +0100
Subject: [PATCH v3 04/12] dt-bindings: add device tree binding for
 X-Powers AXP803 PMIC
In-Reply-To: <20170417115747.7300-5-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-5-icenowy@aosc.io>
Message-ID: <20170424120815.hrduxdbqzcmroy2p@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Apr 2017, Icenowy Zheng wrote:

> AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
> bus.
> 
> Add a compatible for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> - Make the compatible one-liner.
> Changes in v2:
> - Place AXP803 before AXP806/809.
> - Added Chen-Yu's ACK.
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index a3e813f6060a..44df88be3c89 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -6,6 +6,7 @@ axp202 (X-Powers)
>  axp209 (X-Powers)
>  axp221 (X-Powers)
>  axp223 (X-Powers)
> +axp803 (X-Powers)
>  axp809 (X-Powers)
>  
>  Required properties:
> @@ -15,6 +16,7 @@ Required properties:
>      * "x-powers,axp209"
>      * "x-powers,axp221"
>      * "x-powers,axp223"
> +    * "x-powers,axp803"
>      * "x-powers,axp806"
>      * "x-powers,axp809"
>  - reg: The I2C slave address or RSB hardware address for the AXP chip

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
