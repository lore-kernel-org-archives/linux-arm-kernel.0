From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 10:10:16 -0700
Subject: [CFT 09/11] mtd: omap2: add DMA engine support
In-Reply-To: <1339075683.6875.109.camel@sauron.fi.intel.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
 <1339073375.6875.102.camel@sauron.fi.intel.com>
 <20120607131158.GC15973@n2100.arm.linux.org.uk>
 <1339075683.6875.109.camel@sauron.fi.intel.com>
Message-ID: <20120607171015.GK12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Artem Bityutskiy <dedekind1@gmail.com> [120607 06:28]:
> On Thu, 2012-06-07 at 14:11 +0100, Russell King - ARM Linux wrote:
> > No, it makes sense to get this stuff via a single tree all together,
> > because, as you can see from the thread structure, it isn't purely
> > an OMAP thing.
> > 
> > The OMAP stuff depends on a core set, as does a bunch of PL08x and
> > SA11x0 changes.  We can't stuff all that through the OMAP tree, that
> > wouldn't make any sense.
> > 
> > What probably should happen is that the tip of the OMAP stuff gets
> > pulled by Tony into his tree, and we share those commits between my
> > tree and his - and then it doesn't matter what goes in when and by
> > whom.
> 
> Oh, sure, sorry, I actually wanted to say that these to patches should
> _not_ got via the MTD tree.

What Russell is suggesting works good for me.

Regards,

Tony
