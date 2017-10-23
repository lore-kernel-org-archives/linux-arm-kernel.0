From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Oct 2017 17:36:12 -0500
Subject: [PATCH v6 01/12] mmc: dt-bindings: Add reg/source_cg/latch-ck
 for Mediatek MMC bindings
In-Reply-To: <1508118399-21828-2-git-send-email-chaotian.jing@mediatek.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
 <1508118399-21828-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20171023223612.uzl52ux26nuujkt3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 09:46:28AM +0800, Chaotian Jing wrote:
> Change the comptiable for support of multi-platform
> Make compatible explicit, as MMC host of mt8173 has difference with
> mt8135(mt8173 supports hs400 and hs400_tune),so that need separate
> mt8173/mt8135 compatible name.
> Add description for reg
> Add description for source_cg
> Add description for mediatek,latch-ck
> Note that source_cg and mediatek,latch-ck are optional for some projects,
> eg, MT2701 do not have source_cg, and MT2712 do not need
> mediatek,latch-ck
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org> 
