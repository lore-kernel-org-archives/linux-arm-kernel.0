From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Jun 2012 00:32:30 -0700
Subject: [GIT PULL] omap fixes for v3.5-rc4
Message-ID: <20120628073229.GC19842@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc4

for you to fetch changes up to e90b833ee1aae64b6fca2455001323ffe29e1698:

  ARM: OMAP4470: Fix OMAP4470 boot failure (2012-06-27 08:09:59 -0700)

----------------------------------------------------------------
Here's one more regression fix that I missed earlier, and a
trivial fix to get omap4470 booting.

----------------------------------------------------------------
Jon Hunter (1):
      ARM: OMAP4470: Fix OMAP4470 boot failure

Kevin Hilman (1):
      ARM: OMAP2+: nand: fix build error when CONFIG_MTD_ONENAND_OMAP2=n

 arch/arm/mach-omap2/board-flash.c    |    5 -----
 arch/arm/mach-omap2/clock44xx_data.c |    5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)
