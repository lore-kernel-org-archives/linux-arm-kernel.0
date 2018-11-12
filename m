From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 17:37:10 -0600
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: document clk bindings for
 MT7629
In-Reply-To: <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
References: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
 <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
Message-ID: <5bea0ea8.1c69fb81.144ae.8670@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Nov 2018 16:43:56 +0800, Ryder Lee wrote:
> This patch adds the binding documentation for apmixedsys, infracfg,
> pciesys, pericfg, topckgen, ethsys, sgmiisys and ssusbsys for MT7629.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt     | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt   | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt    | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt    | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt   | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt   | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt   | 1 +
>  8 files changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
