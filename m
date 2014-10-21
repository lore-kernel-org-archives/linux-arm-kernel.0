From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Oct 2014 14:40:58 +0100
Subject: [PATCH v3 3/4] mfd/regulator: dt-bindings: max77686: Document
 regulators off in suspend
In-Reply-To: <1413897595-28752-4-git-send-email-k.kozlowski@samsung.com>
References: <1413897595-28752-1-git-send-email-k.kozlowski@samsung.com>
 <1413897595-28752-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141021134058.GE4939@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014, Krzysztof Kozlowski wrote:

> Add information which regulators can be disabled during system suspend.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/mfd/max77686.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

This has been applied already.

> diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
> index 678f3cf0b8f0..75fdfaf41831 100644
> --- a/Documentation/devicetree/bindings/mfd/max77686.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77686.txt
> @@ -34,6 +34,11 @@ to get matched with their hardware counterparts as follow:
>  	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
>  			example: BUCK1, BUCK5, BUCK9.
>  
> +  Regulators which can be turned off during system suspend:
> +	-LDOn	:	2, 6-8, 10-12, 14-16,
> +	-BUCKn	:	1-4.
> +  Use standard regulator bindings for it ('regulator-off-in-suspend').
> +
>  Example:
>  
>  	max77686 at 09 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
