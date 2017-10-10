From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 10 Oct 2017 09:37:53 +0800
Subject: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
In-Reply-To: <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
 <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com>
Message-ID: <1507599473.19789.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-10-09 at 16:54 +0200, Matthias Brugger wrote:
> 
> On 10/09/2017 01:35 PM, Chaotian Jing wrote:
> > the driver has updated to have an explicit compatible, so update
> > binding file according to the driver change.
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 3e0a97c..2bb585b 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
> >   
> >   Required properties:
> >   - compatible: value should be either of the following.
> > -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> > -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
> > +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> > +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> 
> You can merge this with patch 1.

OK, will merge it in next patch.
> 
> >   	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >   	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >   - reg: physical base address of the controller and length
> > 
