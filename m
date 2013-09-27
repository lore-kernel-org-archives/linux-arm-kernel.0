From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 21:52:03 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3tfc9Z14YYm9K0AXNinMDsTwE51_6tbYfyFU7cA8M7MgA@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
 <20130927084504.GW12758@n2100.arm.linux.org.uk>
 <20130927122814.GK25146@S2101-09.ap.freescale.net>
 <20130927131225.GA31178@titan.lakedaemon.net>
 <20130927132107.GZ12758@n2100.arm.linux.org.uk>
 <20130927133120.GC31178@titan.lakedaemon.net>
 <CAHCPf3tfc9Z14YYm9K0AXNinMDsTwE51_6tbYfyFU7cA8M7MgA@mail.gmail.com>
Message-ID: <20130927205203.GL12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 11:33:19AM -0500, Matt Sealey wrote:
> On Fri, Sep 27, 2013 at 8:31 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Fri, Sep 27, 2013 at 02:21:07PM +0100, Russell King - ARM Linux wrote:
> >> On Fri, Sep 27, 2013 at 09:12:25AM -0400, Jason Cooper wrote:
> >> > I'm currently slogging through the exact same issues for adding imx50
> >> > (SanDisk Connect Wireless media Drive).  I thought I was just thick.
> >> > It's a relief to know I'm not the only one having trouble with this.
> >>
> >> I'm coming to the conclusion that it's almost to the point of "vendor
> >> lockin" - you have to find someone who understands this stuff to take
> >> your hardware description and turn it into a working DT description.
> >
> > I don't think it's vendor lock-in, I think Freescale's pinctrl/gpio IP
> > block is just an over-complicated pain in the ass that doesn't lend
> > itself to DT well.
> 
> 
> Me either - device trees aren't vendor lock-in but they ARE a huge
> reminder of how silicon vendors prioritize software development - the
> chip works. The i.MX IOMUX block lends itself VERY well to device
> trees.

The "vendor lock-in" that I'm talking about here is the lock-in to
the people who created the DT mess in the first place, *not* the
silicon vendor.

If it's extremely difficult to understand how to put together the
proper DT description because it's just a load of numbers, and the
knowledge is limited to a few developers, then that makes it really
difficult for 3rd parties to create their own device tree files.

There should be an effort to make writing a DT description as simple
and easy as possible, and part of that means ensuring that the
documentation helps people to understand how to do that, and certainly
doesn't add additional needless to confusion.
