From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Sep 2011 22:18:04 -0600
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <4E77B9E3.40004@gmail.com>
References: <CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com> <4E71F978.6020402@gmail.com>
	<4E72030F.1090300@ti.com> <4E722B2D.4050307@gmail.com>
	<4E76615C.3000005@gmail.com> <4E77310A.3000106@ti.com>
	<4E774847.3020104@gmail.com>
	<CACxGe6v9nd5f5x-eu9hUyAqdS1+p3h6ixyutECYLdNo3ewDH0w@mail.gmail.com>
	<4E77B9E3.40004@gmail.com>
Message-ID: <20110920041804.GD30517@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 04:53:39PM -0500, Rob Herring wrote:
> On 09/19/2011 04:14 PM, Grant Likely wrote:
> > (Alternately, if there is no need for a CPU mask because PPI
> > interrupts will never be wired to more than one CPU, then it would be
> > better to encode the CPU number into the second cell with the SPI
> > number).
> You meant PPI number, right?                                    ^^^

Yes, I meant PPI number.  I keep transposing the two; I don't know why.

> The common case at least on the A9 is a PPI is routed to all cores. QC
> is different though. This was discussed previously. Basically, anything
> is possible here, so the mask is needed for sure.

Okay.

g.
