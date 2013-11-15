From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 14:41:30 +0100
Subject: [PATCH] ARM: at91/dt: binding: add precision to AIC documentation
In-Reply-To: <1384510173-15901-1-git-send-email-nicolas.ferre@atmel.com>
References: <1384510173-15901-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131115134130.GM28304@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:09 Fri 15 Nov     , Nicolas Ferre wrote:
> In response to the "undocumented compatible strings" message, here is a
> patch which is adding the precision of two "chips" that should be used for
> the "atmel,<chip>-aic" compatibility string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
>  Documentation/devicetree/bindings/arm/atmel-aic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
> index ad031211..2742e9c 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-aic.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
> @@ -2,6 +2,7 @@
>  
>  Required properties:
>  - compatible: Should be "atmel,<chip>-aic"
> +  <chip> can be "at91rm9200" or "sama5d3"
>  - interrupt-controller: Identifies the node as an interrupt controller.
>  - interrupt-parent: For single AIC system, it is an empty property.
>  - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
> -- 
> 1.8.2.2
> 
