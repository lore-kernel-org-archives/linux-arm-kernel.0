From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 07 Aug 2014 17:52:20 +0100
Subject: [PATCHv2 3/3] dt-bindings: samsung: exynos_adc: Remove
 un-necessary white-sapce
In-Reply-To: <1406551442-15186-4-git-send-email-cw00.choi@samsung.com>
References: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
 <1406551442-15186-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <53E3AEC4.2050405@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/14 13:44, Chanwoo Choi wrote:
> This patch remove un-necessary white-sapce to code clean.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Applied to the togreg branch of iio.git. Obviously this didn't
need to go through my tree, but as it is so trivial it might
as well do so.

J
> ---
>  Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index 709efaa..5ee0266 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -30,7 +30,7 @@ Required properties:
>  			- The base address and range of ADC register
>  			- The base address and range of ADC_PHY register (every
>  			  SoC except for s3c24xx/s3c64xx ADC)
> -- interrupts: 		Contains the interrupt information for the timer. The
> +- interrupts:		Contains the interrupt information for the timer. The
>  			format is being dependent on which interrupt controller
>  			the Samsung device uses.
>  - #io-channel-cells = <1>; As ADC has multiple outputs
> 
