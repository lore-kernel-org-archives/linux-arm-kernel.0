From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Dec 2009 23:20:39 -0500 (EST)
Subject: Git pull request: small Kirkwood/Dove updates
Message-ID: <alpine.LFD.2.00.0912102315240.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull:

	git://git.marvell.com/orion for-rmk

This contains 2 patches as shown below.  Also please include a 
mach-types update in your next pull request to Linus.

Saeed Bishara (1):
      ARM: dove: fix the mm mmu flags of the pj4 procinfo

Simon Guinot (1):
      [ARM] Kirkwood: Add LaCie Network Space v2 support

 arch/arm/mach-kirkwood/Kconfig             |    6 +
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c |  325 ++++++++++++++++++++++
 arch/arm/mm/proc-v6.S                      |    5 +-
 4 files changed, 334 insertions(+), 3 deletions(-)


Nicolas
