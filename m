From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Apr 2017 16:23:25 -0500
Subject: [PATCH 1/2] dt-bindings: hwrng: Add Mediatek hardware random
 generator bindings
In-Reply-To: <1492067108-14748-2-git-send-email-sean.wang@mediatek.com>
References: <1492067108-14748-1-git-send-email-sean.wang@mediatek.com>
 <1492067108-14748-2-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170419212325.y3t2vohmsuhet2xu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 03:05:07PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for Mediatek random number
> generator which could be found on MT7623 SoC or other similar
> Mediatek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/rng/mtk-rng.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/mtk-rng.txt

Acked-by: Rob Herring <robh@kernel.org>
