From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 14 Apr 2016 09:43:16 +0800
Subject: [PATCH v2 1/2] dt-bindings: phy-mt65xx-usb: add support for
 mt2701 platform
In-Reply-To: <570E18B3.2000101@gmail.com>
References: <1460360490-18606-1-git-send-email-chunfeng.yun@mediatek.com>
 <570E18B3.2000101@gmail.com>
Message-ID: <1460598196.5156.0.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2016-04-13 at 12:00 +0200, Matthias Brugger wrote:
> 
> On 11/04/16 09:41, Chunfeng Yun wrote:
> > A new compatible string, "mediatek,mt2701-u3phy", is added.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |    4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
Thanks

> > diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > index 00100cf..33a2b1e 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > @@ -4,7 +4,9 @@ mt65xx USB3.0 PHY binding
> >   This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
> >
> >   Required properties (controller (parent) node):
> > - - compatible	: should be "mediatek,mt8173-u3phy"
> > + - compatible	: should be one of
> > +		  "mediatek,mt2701-u3phy"
> > +		  "mediatek,mt8173-u3phy"
> >    - reg		: offset and length of register for phy, exclude port's
> >   		  register.
> >    - clocks	: a list of phandle + clock-specifier pairs, one for each
> >
