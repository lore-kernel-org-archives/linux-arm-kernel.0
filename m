From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 14:26:43 -0600
Subject: [PATCH v2 5/8] dt-bindings: allow optional phys in Rockchip
 dw_hdmi binding
In-Reply-To: <20180216204158.29839-6-heiko@sntech.de>
References: <20180216204158.29839-1-heiko@sntech.de>
 <20180216204158.29839-6-heiko@sntech.de>
Message-ID: <20180219202643.mmngucoajdc6kiis@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 09:41:55PM +0100, Heiko Stuebner wrote:
> Some newer Rockchip SoCs use an Innosilicon hdmiphy accessed via general
> mmio, so allow these to be referenced via the regular phy interfaces
> and therefore add optional phy-related properties to the binding.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
