From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 1 Dec 2017 10:23:11 +0800
Subject: [PATCH 1/3] mmc: dt-bindings: add mmc support to MT7623 SoC
In-Reply-To: <20171201020604.etfzccuwomxgcwmg@rob-hp-laptop>
References: <cover.1511949769.git.sean.wang@mediatek.com>
 <3e2c72d18bbe6d7c762fd820195f0fa0b5a45bbf.1511949769.git.sean.wang@mediatek.com>
 <20171201020604.etfzccuwomxgcwmg@rob-hp-laptop>
Message-ID: <1512094991.28444.11.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-11-30 at 20:06 -0600, Rob Herring wrote:
> On Wed, Nov 29, 2017 at 06:10:35PM +0800, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add the devicetree binding for MT7623 SoC using MT2701 as the fallback.
> > 
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 72d2a73..1732588 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -12,6 +12,8 @@ Required properties:
> >  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> > +	"mediatek,mt7623-mmc",
> > +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt7623
> 
> Those should be on 1 line ideally.
> 
> BTW, I find "for mmc host ip compatible with mt7623" to be mostly 
> redundant.
> Either way,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> 

okay, thanks for your careful guide

These will be fixed with 
"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC 
in the next version

	Sean


> >  - reg: physical base address of the controller and length
> >  - interrupts: Should contain MSDC interrupt number
> >  - clocks: Should contain phandle for the clock feeding the MMC controller
> > -- 
> > 2.7.4
> > 
> 
