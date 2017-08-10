From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 13:21:46 -0500
Subject: [PATCH v5 1/1] dt-bindings: mtd: add new compatible strings and
 improve description
In-Reply-To: <1501834239-25581-2-git-send-email-guochun.mao@mediatek.com>
References: <1501834239-25581-1-git-send-email-guochun.mao@mediatek.com>
 <1501834239-25581-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <20170810182146.glmikeqpqwe66dwt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 04:10:39PM +0800, Guochun Mao wrote:
> Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
> for nor flash node's compatible strings.
> Explicate the fallback compatible.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> ---
>  .../devicetree/bindings/mtd/mtk-quadspi.txt        |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
