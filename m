From: a0393675@ti.com (Keerthy)
Date: Thu, 18 Aug 2016 10:28:57 +0530
Subject: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
In-Reply-To: <1471492253-7185-2-git-send-email-dawei.chien@mediatek.com>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
 <1471492253-7185-2-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1b5a218d-0f39-5bed-6881-2f8b74708897@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 18 August 2016 09:20 AM, Dawei Chien wrote:
> This adds the device tree binding documentation for the mediatek thermal
> controller found on Mediatek MT2701.

Reviewed-by: Keerthy <j-keerthy@ti.com>

>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
>  .../bindings/thermal/mediatek-thermal.txt          |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index 81f9a51..e2f494d 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -8,7 +8,9 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
>  is also needed.
>
>  Required properties:
> -- compatible: "mediatek,mt8173-thermal"
> +- compatible:
> +  - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
> +  - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
>  - reg: Address range of the thermal controller
>  - interrupts: IRQ for the thermal controller
>  - clocks, clock-names: Clocks needed for the thermal controller. required
>
