From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 15 Apr 2013 04:07:14 +0100
Subject: [PATCH 0/5 v2] mv643xx_eth: device tree bindings
In-Reply-To: <20130413190037.GY28693@titan.lakedaemon.net>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <20130411165303.GI28693@titan.lakedaemon.net>
 <20130413172126.6cca0809@skate>
 <20130413190037.GY28693@titan.lakedaemon.net>
Message-ID: <1365995234.3566.17.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-04-13 at 15:00 -0400, Jason Cooper wrote:
> On Sat, Apr 13, 2013 at 05:21:26PM +0200, Thomas Petazzoni wrote:
> > Dear Jason Cooper,
> > 
> > On Thu, 11 Apr 2013 12:53:03 -0400, Jason Cooper wrote:
> > 
> > > With this and Thomas' pci series, we will have Kirkwood fully
> > > converted to devicetree, can begin removing board files, and finally
> > > begin migrating everything over to mach-mvebu/.  This will lead to
> > > the removal of five directories under arch/arm/ (plat-orion,
> > > mach-kirkwood, mach-orion5x, mach-dove, and mach-mv78xx0).
> > 
> > No, we can't remove mach-orion5x and mach-mv78xx0 for now, they have
> > not been converted at all in terms of gpio/pinmux support. I've started
> > writing some pinmux code for orion5x but it's not ready.
[...]
> Also, I have a feeling that not all legacy boards will get converted
> over.  If there is no interest or no way to test, certains boards may
> get deprecated.

Debian supports many Kirkwood and Orion 5x systems.  A call for testing
on the debian-arm at lists.debian.org list might be worthwhile.

I would be very glad to see kirkwood, orion5x and mv78xx0 merged - we
build natively and this takes about 8 hours for each configuration.

Ben.

-- 
Ben Hutchings
The first rule of tautology club is the first rule of tautology club.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130415/2648cd5c/attachment.sig>
