From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 10 Oct 2015 16:42:04 +0200
Subject: [PATCH 2/2] dt-bindings: Add new boards to bcm4708 DT bindings
In-Reply-To: <1443824564-17291-2-git-send-email-jonmason@broadcom.com>
References: <1443824564-17291-1-git-send-email-jonmason@broadcom.com>
 <1443824564-17291-2-git-send-email-jonmason@broadcom.com>
Message-ID: <561923BC.5040906@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2015 12:22 AM, Jon Mason wrote:
> Add the 4708, 4709, and 953012k SVKs to the the documentation for the
> Broadcom Northstar device tree bindings.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> index 6b0f49f..bdf4c06 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt

What should be documented in this file? This is more a question to the
guys more familiar with arm in Linux. Currently the Linux kernel only
supports brcm,bcm4708 and all goes back to that one.

> @@ -5,4 +5,11 @@ Boards with the BCM4708 SoC shall have the following properties:
>  
>  Required root node property:
>  
> +bcm94709
>  compatible = "brcm,bcm4708";
> +
> +bcm94709
> +compatible = "brcm,bcm4709", "brcm,bcm4708";
> +
> +bcm953012k
> +compatible = "brcm,bcm5301k", "brcm,bcm4708";
> 
