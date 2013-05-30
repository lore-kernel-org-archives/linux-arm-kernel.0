From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 29 May 2013 20:26:22 -0400
Subject: [GIT PULL 2/5] ARM: mvebu: pcie driver for v3.11 (round 2
 cumulative)
In-Reply-To: <20130529232220.6058.14477@quantum>
References: <20130528202140.GG31290@titan.lakedaemon.net>
 <20130528202433.GH31290@titan.lakedaemon.net>
 <20130529232220.6058.14477@quantum>
Message-ID: <20130530002622.GB31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 04:22:20PM -0700, Mike Turquette wrote:
> Quoting Jason Cooper (2013-05-28 13:24:33)
> > The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
> > 
> >   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/pcie-3.11-2
> > 
> > for you to fetch changes up to 3d9939c92efdd4ced672b94994959ca71b141cb8:
> > 
> >   pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu pcie driver for v3.11 (round 2, bugfix)
> > 
> >  - mvebu pcie
> >     - fix return value check in mvebu_pcie_probe()
> > 
> > depends
> >  - mvebu/of_pci
> > 
> > ----------------------------------------------------------------
> > Thomas Petazzoni (4):
> >       clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
> >       clk: mvebu: add more PCIe clocks for Armada XP
> 
> Same story here for pull request #2 as for pull request #5.  The clock
> changes are trivial: Ack.  However if it is a pain to add the ack don't
> worry about it.

Ok, thanks for the Ack.  In this case, I'm going to wave off.  I would
have to rebase 4 branches (3 depend on this one) and send 4 new PRs.

thx,

Jason.
