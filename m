From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 08:55:26 +0200
Subject: [PATCH v4 10/11] dt-bindings: orion-mdio: document the new xmdio
 compatible
In-Reply-To: <20170614163537.GO15847@lunn.ch>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-11-antoine.tenart@free-electrons.com>
 <20170614163537.GO15847@lunn.ch>
Message-ID: <20170615065526.GA4773@kwain.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jun 14, 2017 at 06:35:37PM +0200, Andrew Lunn wrote:
> On Wed, Jun 14, 2017 at 05:49:10PM +0200, Antoine Tenart wrote:
> >  
> >  The Ethernet controllers of the Marvel Kirkwood, Dove, Orion5x,
> > -MV78xx0, Armada 370 and Armada XP have an identical unit that provides
> > -an interface with the MDIO bus. This driver handles this MDIO
> > -interface.
> > +MV78xx0, Armada 370, Armada XP, Armada 7k and Armada 8k have an
> > +identical unit that provides an interface with the MDIO bus or
> > +with the xMDIO bus. This driver handles these interfaces.
> 
> This patches is looking good now. One nit. The description above
> suggests Kirkwood, Dove, Orion5x, MV78xx0, Armada 370 and Armada XP
> all have xmdio. Maybe better wording would be:
> 
> The Ethernet controllers of the Marvel Kirkwood, Dove, Orion5x,
> MV78xx0, Armada 370, Armada XP, Armada 7k and Armada 8k have an
> identical unit that provides an interface with the MDIO bus.
> Additionally, Armada 7k and Armada 8k has a second unit which
> provides an interface with the xMDIO bus. This driver handles
> these interfaces.

Agreed, your description is better :)
I'll respin this patch only, if there is no other comment.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170615/b4fb6e80/attachment.sig>
