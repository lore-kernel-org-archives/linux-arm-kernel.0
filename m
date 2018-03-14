From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 14 Mar 2018 14:09:44 +0800
Subject: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2
 slew rate calibrate
In-Reply-To: <6810b7b4-3023-2e76-5fbf-7e442067cbc4@gmail.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
 <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
 <6810b7b4-3023-2e76-5fbf-7e442067cbc4@gmail.com>
Message-ID: <1521007784.3717.17.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-14 at 00:21 +0100, Matthias Brugger wrote:
> 
> On 03/12/2018 06:25 AM, Chunfeng Yun wrote:
> > Add two properties of ref_clk and coefficient used by U2 slew rate
> > calibrate which may vary on different SoCs
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
Thanks again

> > ---
> >  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > index 41e09ed..0d34b2b 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > @@ -27,6 +27,10 @@ Optional properties (controller (parent) node):
> >   - reg		: offset and length of register shared by multiple ports,
> >  		  exclude port's private register. It is needed on mt2701
> >  		  and mt8173, but not on mt2712.
> > + - mediatek,src-ref-clk-mhz	: frequency of reference clock for slew rate
> > +		  calibrate
> > + - mediatek,src-coef	: coefficient for slew rate calibrate, depends on
> > +		  SoC process
> >  
> >  Required properties (port (child) node):
> >  - reg		: address and length of the register set for the port.
> > 
