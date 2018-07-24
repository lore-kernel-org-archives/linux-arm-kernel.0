From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 24 Jul 2018 13:40:04 +0800
Subject: [PATCH 2/3] dt-bindings: arm: syna: add support for the AS370 SoC
In-Reply-To: <20180720151529.GA26487@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
 <20180713172457.6193a92f@xhacker.debian>
 <20180720151529.GA26487@rob-hp-laptop>
Message-ID: <20180724134004.4fc660d6@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On Fri, 20 Jul 2018 09:15:29 -0600 Rob Herring wrote:

> On Fri, Jul 13, 2018 at 05:24:57PM +0800, Jisheng Zhang wrote:
> > The AS370 SoC is a new derivative of the berlin family. The only
> > difference is the SoC isn't named as berlin*.  
> 
> So is it a derivative or just rebranded?

A derivative new generation SoC.

> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  Documentation/devicetree/bindings/arm/syna.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
> > index 3bab18409b7a..3ba1d7b5ee74 100644
> > --- a/Documentation/devicetree/bindings/arm/syna.txt
> > +++ b/Documentation/devicetree/bindings/arm/syna.txt
> > @@ -1,4 +1,4 @@
> > -Marvell Berlin SoC Family Device Tree Bindings
> > +Synaptics SoC Device Tree Bindings  
> 
> Perhaps some note about what has happened here. Otherwise it looks 
> strange having "Marvell Berlin" in the document when the title says 
> Synaptics SoC.

Good idea. will do in v2

> 
> >  ---------------------------------------------------------------
> >  
> >  Work in progress statement:
> > @@ -13,6 +13,10 @@ stable binding/ABI.
> >  
> >  ---------------------------------------------------------------
> >  
> > +Boards with the Synaptics AS370 SoC shall have the following properties:
> > +  Required root node property:
> > +    compatible: "syna,as370"
> > +
> >  Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
> >  shall have the following properties:
> >  
> > -- 
> > 2.18.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
