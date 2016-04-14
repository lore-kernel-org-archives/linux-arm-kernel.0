From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 14 Apr 2016 09:45:17 +0800
Subject: [PATCH v2 1/2] dt-bindings: phy-mt65xx-usb: add support for
 mt2701 platform
In-Reply-To: <570E48EA.4030907@ti.com>
References: <1460360490-18606-1-git-send-email-chunfeng.yun@mediatek.com>
 <570E48EA.4030907@ti.com>
Message-ID: <1460598317.5156.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2016-04-13 at 18:56 +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 11 April 2016 01:11 PM, Chunfeng Yun wrote:
> > A new compatible string, "mediatek,mt2701-u3phy", is added.
> 
> how about changing the commit log to something like below?
> Add a new compatible string for "mt2701"
> 
OK

thanks

> Thanks
> Kishon
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > index 00100cf..33a2b1e 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > @@ -4,7 +4,9 @@ mt65xx USB3.0 PHY binding
> >  This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
> >  
> >  Required properties (controller (parent) node):
> > - - compatible	: should be "mediatek,mt8173-u3phy"
> > + - compatible	: should be one of
> > +		  "mediatek,mt2701-u3phy"
> > +		  "mediatek,mt8173-u3phy"
> >   - reg		: offset and length of register for phy, exclude port's
> >  		  register.
> >   - clocks	: a list of phandle + clock-specifier pairs, one for each
> > 
