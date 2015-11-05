From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Nov 2015 17:45:43 -0600
Subject: [PATCH v2 1/9] dt-bindings: rockchip-thermal: Support the RK3368
 SoCs compatible
In-Reply-To: <1446700685-18017-2-git-send-email-wxt@rock-chips.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1446700685-18017-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20151105234543.GA32342@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 01:17:57PM +0800, Caesar Wang wrote:
> This patchset attempts to new compatible for thermal founding
> on RK3368 SoCs.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> 
> Changes in v2: None
> Changes in v1:
> - %s/thermal/rockchip-thermal in subject.
> 
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index b38200d..0dfa60d 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -1,7 +1,9 @@
>  * Temperature Sensor ADC (TSADC) on rockchip SoCs
>  
>  Required properties:
> -- compatible : "rockchip,rk3288-tsadc"
> +- compatible : should be "rockchip,<name>-tsadc"
> +   "rockchip,rk3288-tsadc": found on RK3288 SoCs
> +   "rockchip,rk3368-tsadc": found on RK3368 SoCs
>  - reg : physical base address of the controller and length of memory mapped
>  	region.
>  - interrupts : The interrupt number to the cpu. The interrupt specifier format
> -- 
> 1.9.1
> 
