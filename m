From: marex@denx.de (Marek Vasut)
Date: Fri, 23 Aug 2013 12:42:12 +0200
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130823094141.GE25263@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <201308230158.05909.marex@denx.de> <20130823094141.GE25263@sirena.org.uk>
Message-ID: <201308231242.12784.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

> On Fri, Aug 23, 2013 at 01:58:05AM +0200, Marek Vasut wrote:
> > > I was actually thinking something more generic than that - putting the
> > > property at the SPI generic bindings level.  Though if all flashes with
> > > this dual/quad read functionality have the prefix m25p the above would
> > > work also, at the minute this does seem to be mostly used by flash (I
> > > bet someone's got some DSPs or something though).
> > 
> > Ah! So you mean the SPI controller would provide information that it can
> > do dual/quad transfers? But then, the additional pins can only be wired
> > to certain chips (controller by certain CS lines).
> 
> No, not exactly - I just meant that the property on the child node
> should be one that's consistent over all chips and could hopefully be
> implemented in the SPI core as part of instantiating the device in DT.
> Which probably just means stripping or changing the vendor prefix.

Ah right, got you now. Thanks!

Best regards,
Marek Vasut
