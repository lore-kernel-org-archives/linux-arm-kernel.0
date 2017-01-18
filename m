From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 16:08:09 -0600
Subject: [PATCH v1 1/2] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <20170113151326.11e9451a@bbrezillon>
References: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
 <1484291609-20195-2-git-send-email-guochun.mao@mediatek.com>
 <20170113151326.11e9451a@bbrezillon>
Message-ID: <20170118220809.pmaa2f3kwiddehti@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 03:13:26PM +0100, Boris Brezillon wrote:
> On Fri, 13 Jan 2017 15:13:28 +0800
> Guochun Mao <guochun.mao@mediatek.com> wrote:
> 
> > Add "mediatek,mt2701-nor" for nor flash node's compatible.
> > 
> > Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> > ---
> >  .../devicetree/bindings/mtd/mtk-quadspi.txt        |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > index fb314f0..f83d31d 100644
> > --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > @@ -1,7 +1,9 @@
> >  * Serial NOR flash controller for MTK MT81xx (and similar)
> >  
> >  Required properties:
> > -- compatible: 	  should be "mediatek,mt8173-nor";
> > +- compatible: 	  should contain:
> > +		  "mediatek,mt2701-nor" for MT2701,
> > +		  "mediatek,mt8173-nor" for MT8173.
> 
> Do you need to define a new compatible? If the IPs are exactly the same
> in both SoCs it shouldn't be needed.

Rather the 2701 should contain both strings in that case.

Rob
