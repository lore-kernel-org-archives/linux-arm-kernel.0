From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 14:30:41 -0600
Subject: [PATCH 1/3] dt-bindings: gpu: mali-utgard: add
 rockchip,rk3328-mali compatible
In-Reply-To: <20171209000738.32187-2-heiko@sntech.de>
References: <20171209000738.32187-1-heiko@sntech.de>
 <20171209000738.32187-2-heiko@sntech.de>
Message-ID: <20171215203041.lm22qrdt2dojoae3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 09, 2017 at 01:07:36AM +0100, Heiko Stuebner wrote:
> The rk3328 quad-core Cortex A53 uses a Mali-450MP2 with 2 PPs, so
> add a compatible for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
>  1 file changed, 1 insertion(+)

For the series,

Reviewed-by: Rob Herring <robh@kernel.org>

Though I don't think it's really necessary to enable the gpu per board 
as it has no pinout. Default enabled would be better IMO.

Rob
