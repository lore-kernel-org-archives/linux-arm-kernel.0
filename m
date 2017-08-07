From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Aug 2017 16:43:25 +0100
Subject: [PATCH v2 1/9] dt-bindings: mfd: axp20x: Add AXP806 to supported
 list of chips
In-Reply-To: <20170726082832.16789-2-wens@csie.org>
References: <20170726082832.16789-1-wens@csie.org>
 <20170726082832.16789-2-wens@csie.org>
Message-ID: <20170807154325.f6nmbu7dkadfaht4@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jul 2017, Chen-Yu Tsai wrote:

> The binding already lists compatibles and regulators for the AXP806,
> but it is missing from the list of supported chips at the beginning.
> 
> Add it.
> 
> Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index aca09af66514..211a100c6b20 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -7,6 +7,7 @@ axp209 (X-Powers)
>  axp221 (X-Powers)
>  axp223 (X-Powers)
>  axp803 (X-Powers)
> +axp806 (X-Powers)
>  axp809 (X-Powers)
>  
>  Required properties:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
