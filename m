From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 12:53:03 -0300
Subject: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
In-Reply-To: <20140416154435.GG28159@titan.lakedaemon.net>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416154435.GG28159@titan.lakedaemon.net>
Message-ID: <20140416155303.GC1892@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 16, Jason Cooper wrote:
> On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> > In addition, we also add support for the Z1 SoC stepping, which needs
> > an initialization-quirk to work properly.
> ...
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > index fff93d5..745d241 100644
> > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -4,8 +4,15 @@ Required properties:
> >  
> >  - compatible:	Should be set to one of the following:
> >  		marvell,armada370-thermal
> > +		marvell,armada375-thermal
> > +		marvell,armada375-z1-thermal
> >  		marvell,armadaxp-thermal
> >  
> > +		Note: As the name suggests, "marvell,armada375-z1-thermal"
> > +		applies for the SoC Z1 stepping only. The operating system
> > +		may auto-detect the SoC stepping and update the compatible
> > +		at runtime.
> 
> Please also include a statement in here regarding the register quirk for
> the z1 stepping.
> 

Sure, no problem.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
