From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 21 Jun 2014 01:24:24 +0200
Subject: [PATCHv4 1/4] ARM: Kirkwood: Add setup file for netxbig LEDs
In-Reply-To: <20140620205147.GL21711@titan.lakedaemon.net>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-2-git-send-email-andrew@lunn.ch>
 <20140620205147.GL21711@titan.lakedaemon.net>
Message-ID: <20140620232424.GT20207@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:51:47PM -0400, Jason Cooper wrote:
> On Mon, May 26, 2014 at 09:29:48PM +0200, Andrew Lunn wrote:
> > There is currently no DT binding for the CPLD which controls the LEDs
> > on the Net 2Big and Net 5Big. So use a platform device.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > v3-v4:
> >   rename board-nextbig.c to nextbig.c
> > ---
> >  arch/arm/mach-mvebu/Kconfig    |   7 ++
> >  arch/arm/mach-mvebu/Makefile   |   1 +
> >  arch/arm/mach-mvebu/board.h    |   5 ++
> >  arch/arm/mach-mvebu/kirkwood.c |   3 +
> >  arch/arm/mach-mvebu/netxbig.c  | 191 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 207 insertions(+)
> >  create mode 100644 arch/arm/mach-mvebu/netxbig.c
> 
> Applied to mvebu/soc

Hi Jason and Andrew,

First, I apologize for being late (as usual).

Some fixes are still needed for this patch series. See my incoming
comments.

Let me know if you want me to send a patch rather than comments.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/23f37bc7/attachment.sig>
