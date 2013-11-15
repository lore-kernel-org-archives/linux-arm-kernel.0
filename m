From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 14:41:14 +0100
Subject: [PATCH] ARM: at91/dt: binding: add missing compatibility string
 in SDRAM/DDR documentation
In-Reply-To: <1384510235-16083-1-git-send-email-nicolas.ferre@atmel.com>
References: <1384510235-16083-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131115134114.GL28304@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:10 Fri 15 Nov     , Nicolas Ferre wrote:
> The "atmel,at91rm9200-sdramc" was missing from binding documentation.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 1196290..d2170e7 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -50,7 +50,8 @@ Example:
>  	};
>  
>  RAMC SDRAM/DDR Controller required properties:
> -- compatible: Should be "atmel,at91sam9260-sdramc",
> +- compatible: Should be "atmel,at91rm9200-sdramc",
> +			"atmel,at91sam9260-sdramc",
>  			"atmel,at91sam9g45-ddramc",
>  - reg: Should contain registers location and length
>    For at91sam9263 and at91sam9g45 you must specify 2 entries.
> -- 
> 1.8.2.2
> 
