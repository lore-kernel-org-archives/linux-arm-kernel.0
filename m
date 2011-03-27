From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 27 Mar 2011 09:41:13 -0400 (EDT)
Subject: Git pull request: Orion/Kirkwood/Dove fixes
Message-ID: <alpine.LFD.2.00.1103270932590.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

to get the following fixes:

Alexander Clouter (1):
      ARM: orion5x: replace printk with pr_{err,info,...} in ts78xx-setup.c

Konstantin Porotchkin (1):
      Fix the broken build for Marvell Dove platform.

Robin Becker (1):
      arm: mach-kirkwood: add led in sheevaplug-setup.c

 arch/arm/mach-dove/include/mach/dove.h    |    2 +-
 arch/arm/mach-dove/mpp.c                  |    3 ---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |    7 +++++++
 arch/arm/mach-orion5x/ts78xx-setup.c      |   18 +++++++++---------
 4 files changed, 17 insertions(+), 13 deletions(-)
