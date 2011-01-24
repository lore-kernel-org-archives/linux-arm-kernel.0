From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Jan 2011 12:04:34 +0000
Subject: [PATCH] Realview: name configuration options after actual
	board names
In-Reply-To: <20110124110025.GI16202@n2100.arm.linux.org.uk>
References: <20110122183038.GA11960@n2100.arm.linux.org.uk>
	<AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
	<20110123155549.GF30094@n2100.arm.linux.org.uk>
	<1295865588.14687.36.camel@e102109-lin.cambridge.arm.com>
	<20110124105427.GH16202@n2100.arm.linux.org.uk>
	<20110124110025.GI16202@n2100.arm.linux.org.uk>
Message-ID: <1295870674.14687.97.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 11:00 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 10:54:27AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 24, 2011 at 10:39:48AM +0000, Catalin Marinas wrote:
> > > On Sun, 2011-01-23 at 15:55 +0000, Russell King - ARM Linux wrote:
> > > > On Sun, Jan 23, 2011 at 11:02:30AM +0000, Catalin Marinas wrote:
> > > > > On Saturday, 22 January 2011, Russell King - ARM Linux
> > > > > <linux@arm.linux.org.uk> wrote:
> > > > > > I haven't significantly updated the descriptions for the tiles as that
> > > > > > is even less clear - as far as I can see on ARMs website, there is no
> > > > > > Cortex-A9 tile for Realview EB - only ARM11MPCore, ARM1156T2F-S,
> > > > > > ARM1176TZF-S and Cortex-R4F.  So exactly what this 'Multicore Cortex-A9
> > > > > > Tile' is..
> > > > >
> > > > > AFAIK there isn't any official A9 tile for EB. this configuration has
> > > > > been used in processor validation and also on the ARMv7 software
> > > > > models, that's why we pushed this option. You can remove it if you
> > > > > want, we'll probably keep it around in our patches.
> > > >
> > > > But otherwise that's an ack for the patch?
> > >
> > > It looks fine to me.
> > >
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Thanks.  I'm going to do a similar thing for Versatile as well, even
> > though the names aren't soo confusing.
> 
> Ack?

Yes.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
