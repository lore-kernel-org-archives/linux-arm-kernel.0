From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 16 Oct 2015 23:42:17 +0200
Subject: [PATCH v3 1/2] dt-bindings: Add new SoCs to bcm4708 DT bindings
In-Reply-To: <1444947856-26246-1-git-send-email-jonmason@broadcom.com>
References: <1444947856-26246-1-git-send-email-jonmason@broadcom.com>
Message-ID: <56216F39.3020400@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2015 12:24 AM, Jon Mason wrote:
> Add the 4708, 4709, and 53012 SoCs to the the documentation for the
> Broadcom Northstar device tree bindings.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> index 6b0f49f..8608a77 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> @@ -5,4 +5,11 @@ Boards with the BCM4708 SoC shall have the following properties:
>  
>  Required root node property:
>  
> +bcm4708
>  compatible = "brcm,bcm4708";
> +
> +bcm4709
> +compatible = "brcm,bcm4709";
> +
> +bcm53012
> +compatible = "brcm,bcm53012";
> 
