From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Sep 2012 21:48:36 -0400
Subject: [GIT PULL V4 4a/5] ARM: Kirkwood: cleanup for v3.7
In-Reply-To: <20120921195714.GY5469@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921195714.GY5469@titan.lakedaemon.net>
Message-ID: <20120922014836.GA5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Of course, the best ideas hit after you relax.  I am sending a V4 of
this pullrq split into two.

 * This does not affect the other branches at all
 * this separates out the platform_data conversion for kirkwood so that
   if it conflicts with others, you can drop it easily.

So, this pullrq (a) is just cleanup.  pullrq (b) is platform_data only
and nothing else in the series of pullrq's depends on it.  Use it, drop
it, doesn't matter.  I sincerely hope that helps.

thx,

Jason.

The following changes since commit 68fa6eb9d0dd41b1bb72bade6f6307193b18fbd1:

  Merge branch 'kirkwood/boards' into kirkwood/cleanup (2012-09-21 18:54:20 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

Jamie Lentin (1):
      ARM: kirkwood: Trim excess #includes in board-dnskw.c

Jason Cooper (1):
      ARM: Kirkwood: ehci now specified in kirkwood.dtsi.  remove legacy platform init

 arch/arm/mach-kirkwood/board-dnskw.c          |    9 ---------
 arch/arm/mach-kirkwood/board-dockstar.c       |    1 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    2 --
 arch/arm/mach-kirkwood/board-km_kirkwood.c    |    1 -
 4 files changed, 0 insertions(+), 13 deletions(-)
