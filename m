From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Aug 2017 13:27:22 -0500
Subject: [PATCH v2 1/3] dt-bindings: add compatible string for Allwinner
 V3s SoC
In-Reply-To: <20170822052322.15338-1-icenowy@aosc.io>
References: <20170822052322.15338-1-icenowy@aosc.io>
Message-ID: <20170825182722.dhnj6dfta4hakmn6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 01:23:20PM +0800, Icenowy Zheng wrote:
> The compatible string for Allwinner V3s SoC used to be missing.
> 
> Add it to the binding document.
> 
> Fixes: b074fede01c0 ("arm: sunxi: add support for V3s SoC")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
