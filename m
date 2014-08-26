From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Aug 2014 08:18:37 +0100
Subject: [PATCH] ARM: cns3xxx: Don't allocate PCI addresses on stack
In-Reply-To: <2791908.V6o8lplUAt@wuerfel>
References: <1408927894-30858-1-git-send-email-broonie@kernel.org>
 <2492333.HstnrugmgL@wuerfel> <2791908.V6o8lplUAt@wuerfel>
Message-ID: <20140826071837.GW17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 01:30:22PM +0200, Arnd Bergmann wrote:
> On Monday 25 August 2014 12:34:25 Arnd Bergmann wrote:

> > However, refactoring the code to do it right seems like actual work
> > and I'm not sure we can find anybody to do it, so your hack seems
> > like the best approximation.

> I may have spoken too fast. Here is a patch that should deal with the
> problem more cleanly, and also help prepare that code for a potential
> move to the changed PCI probing infrastructure that is getting
> done for arm64.

> Completely untested.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Right, this looks reasonably sensible to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/07eba653/attachment.sig>
