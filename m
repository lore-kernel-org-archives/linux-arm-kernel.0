From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 14 Dec 2017 22:20:29 +0800
Subject: [PATCH v2 1/3] mmc: dt-bindings: add mmc support to MT7623 SoC
In-Reply-To: <86e53802-9bb4-35eb-66e1-f9a401e31863@gmail.com>
References: <cover.1512628593.git.sean.wang@mediatek.com>
 <4f06b509e1e3d4cf5578841cfcf7ec966afd2d48.1512628593.git.sean.wang@mediatek.com>
 <86e53802-9bb4-35eb-66e1-f9a401e31863@gmail.com>
Message-ID: <1513261229.28444.33.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-14 at 12:16 +0100, Matthias Brugger wrote:
> Hi Ulf,
> 
> On 12/07/2017 07:43 AM, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add the devicetree binding for MT7623 SoC using MT2701 as the fallback.
> > 
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 72d2a73..9b80176 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -12,6 +12,8 @@ Required properties:
> >  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> > +	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
> > +
> >  - reg: physical base address of the controller and length
> >  - interrupts: Should contain MSDC interrupt number
> >  - clocks: Should contain phandle for the clock feeding the MMC controller
> > 
> 
> Are you fine to take this patch through your branch, or shall I take it through
> mine?
> 
> @Sean it seems you forgot to send this patch to Ulf as well. In the future
> please take care to send the patch to all relevant people and mailinglist.
> 

Okay. I'll be. really sorry for the inconvenience

> Thanks,
> Matthias
> 
