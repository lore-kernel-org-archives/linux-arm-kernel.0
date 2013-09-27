From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Sep 2013 09:31:20 -0400
Subject: device tree binding documentation outdated
In-Reply-To: <20130927132107.GZ12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
 <20130927084504.GW12758@n2100.arm.linux.org.uk>
 <20130927122814.GK25146@S2101-09.ap.freescale.net>
 <20130927131225.GA31178@titan.lakedaemon.net>
 <20130927132107.GZ12758@n2100.arm.linux.org.uk>
Message-ID: <20130927133120.GC31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 02:21:07PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 27, 2013 at 09:12:25AM -0400, Jason Cooper wrote:
> > I'm currently slogging through the exact same issues for adding imx50
> > (SanDisk Connect Wireless media Drive).  I thought I was just thick.
> > It's a relief to know I'm not the only one having trouble with this.
> 
> I'm coming to the conclusion that it's almost to the point of "vendor
> lockin" - you have to find someone who understands this stuff to take
> your hardware description and turn it into a working DT description.

I don't think it's vendor lock-in, I think Freescale's pinctrl/gpio IP
block is just an over-complicated pain in the ass that doesn't lend
itself to DT well.

thx,

Jason.
