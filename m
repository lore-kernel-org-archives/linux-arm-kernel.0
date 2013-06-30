From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sun, 30 Jun 2013 10:48:46 +0100
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
In-Reply-To: <20130629193819.GD3353@n2100.arm.linux.org.uk>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130628171532.GD30603@e102568-lin.cambridge.arm.com>
 <20130628200333.GA2756@lukather>
 <CAOesGMgsD+tK4+ywvLzsWd+mngrP7zGgSFn0naWjSsQLGaUn2Q@mail.gmail.com>
 <20130629193819.GD3353@n2100.arm.linux.org.uk>
Message-ID: <20130630094846.GA27559@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 08:38:19PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 28, 2013 at 01:05:42PM -0700, Olof Johansson wrote:
> > On Fri, Jun 28, 2013 at 1:03 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Fri, Jun 28, 2013 at 06:15:32PM +0100, Lorenzo Pieralisi wrote:
> > >> The patch above should already be queued in next/dt right ?
> > >
> > > Indeed.
> > >
> > > Then why the latest patch of your patchset got in 3.10, while the
> > > patches actually fixing the DT it would have impacted were delayed to
> > > 3.11?
> > >
> > > (And why was it merged so late in the development cycle?)
> > 
> > This. So now we have to scramble because some device trees will
> > produce warnings at boot.
> > 
> > Russell, the alternative is to revert Lorenzo's patch for 3.10 (and
> > re-introduce it for 3.11). Do you have a preference?
> 
> Sorry but I really don't understand what all the fuss in this thread
> is about.
> 
> This thread seems to be saying that two development patches were
> merged, which were 7762/1 and 7763/1, and that 7764/1 is a fix?
> Are you sure about that, because that's not how they're described,
> and not how they look either.

As Olof's warning downgrade is being merged (thanks for that and apologies for
failing to explain patches dependencies properly and stable related issues),
7764/1 won't apply cleanly anymore. Can you please drop it from the patch
system, I will update it and test it first thing tomorrow and send a
final version to the patch system.

Thank you very much,
Lorenzo
