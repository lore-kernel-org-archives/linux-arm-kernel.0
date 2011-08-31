From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 31 Aug 2011 12:32:29 +1000
Subject: How to handle named resources with DT?
In-Reply-To: <20110830092722.GG23907@legolas.emea.dhcp.ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de> <4E57A9FB.5030404@ti.com>
	<20110830022912.GE4254@yookeroo.fritz.box>
	<20110830092722.GG23907@legolas.emea.dhcp.ti.com>
Message-ID: <20110831023229.GF11906@yookeroo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 12:27:24PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Aug 30, 2011 at 12:29:12PM +1000, David Gibson wrote:
> > So, I actually agree that in the long term getting resource names in
> > the DT would be a generally good thing.
> > 
> > But doing so is a *huge* change in one of the very core semantics of
> > all the DT bindings.  It's not something that should be done lightly
> > or quickly.  It absolutely should not be tied to how this is handled
> 
> the longer you take to change, the more complex will it be to
> change.

No, not really.

> The longer we spend discussing the validity of _byname(), more
> boards/archs/whatnot will be converted to DT without _byname() and after
> a certain amount of them are converted, noone will be willing to change
> and validate everything again.

I'm not discussing the validity of _byname (Russell King is, but
that's not an argument I have a position of).  What I'm saying is that
the kernel internal use of byname, and named resources in the DT are
different things which should be approached independently.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110831/04e80fbe/attachment.sig>
