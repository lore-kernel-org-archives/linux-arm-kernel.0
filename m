From: s-anna@ti.com (Anna, Suman)
Date: Fri, 21 Jun 2013 16:39:57 +0000
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
In-Reply-To: <20130621064526.GJ5523@atomide.com>
References: <20130621160800.64f9965229e5042a7b77e212@canb.auug.org.au>
 <20130621064526.GJ5523@atomide.com>
Message-ID: <37C860A02101E749A747FA2D3C1E3C504CDAAE@DLEE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * Stephen Rothwell <sfr@canb.auug.org.au> [130620 23:14]:
> > Hi all,
> >
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-omap2/devices.c between commit 4a1c0e83bb4e ("ARM:
> OMAP2+:
> > mbox: remove dependencies with soc.h") from the mailbox tree and commit
> > 82c5cde1c4b0 ("ARM: OMAP2+: Remove omap4 ocp2scp pdata") from the arm-
> soc
> > tree.
> >
> > I fixed it up (removing the include of
> > linux/platform_data/omap_ocp2scp.h) and can carry the fix as necessary
> > (no action is required).
> 
> Thanks, that's the right fix as that header won't be needed any longer
> as we've made omap4 device tree only.
> 
> > That mailbox tree commit looks very similar to commit b8a7cf8e2b15 ("ARM:
> > OMAP2+: mbox: remove dependencies with soc.h") from the arm-soc tree ...
> 
> The earlier mailbox branch was merged into arm-soc for a few weeks until
> we decided to drop it as Jassi is working on a more generic API. That was
> merged in commit 51b5f893, then reverted in commit b5c85186. The updated
> mailbox branch accounts for the generic API coming up from Jassi.
> 
> Suman, can you please check if Linux next has mailbox related files merged
> correctly?

Yes, they look good.

Regards
Suman
