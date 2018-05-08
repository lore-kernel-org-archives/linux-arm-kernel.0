From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 8 May 2018 09:03:09 +0800
Subject: [PATCH v2 1/2] dt-bindings: add MediaTek XS-PHY binding
In-Reply-To: <20180507170435.GA14540@rob-hp-laptop>
References: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
 <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
 <20180507170435.GA14540@rob-hp-laptop>
Message-ID: <1525741389.25162.37.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-05-07 at 12:04 -0500, Rob Herring wrote:
> On Sat, May 05, 2018 at 10:15:05AM +0800, Chunfeng Yun wrote:
> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
> > with USB3.1 GEN2 controller
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > new file mode 100644
> > index 0000000..9a95fab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > @@ -0,0 +1,110 @@
> > +MediaTek XS-PHY binding
> > +--------------------------
> > +
> > +The XS-PHY controller supports physical layer functionality for USB3.1
> > +GEN2 controller on MediaTek SoCs.
> > +
> > +Required properties (controller (parent) node):
> > + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> > + 		  soc-model is the name of SoC, such as mt2712 etc;
> > +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> > +		  ones in addition, one of:
> > +		  - "mediatek,mt3611-xsphy"
> 
> What about mt2712 you mention above?
Sorry, forgot to modify it
