From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 07:55:19 -0500
Subject: [PATCH v2 1/2] dt-bindings: net: meson-dwmac: new compatible
 name for AXG SoC
In-Reply-To: <20180428102111.18384-2-yixun.lan@amlogic.com>
References: <20180428102111.18384-1-yixun.lan@amlogic.com>
 <20180428102111.18384-2-yixun.lan@amlogic.com>
Message-ID: <20180501125519.GA14984@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2018 at 10:21:10AM +0000, Yixun Lan wrote:
> We need to introduce a new compatible name for the Meson-AXG SoC
> in order to support the RMII 100M ethernet PHY, since the PRG_ETH0
> register of the dwmac glue layer is changed from previous old SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/net/meson-dwmac.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
