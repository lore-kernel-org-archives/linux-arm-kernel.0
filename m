From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 29 Oct 2010 19:11:48 -0400 (EDT)
Subject: Git pull request: last bits for Kirkwood
Message-ID: <alpine.LFD.2.00.1010291906590.12140@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull the following:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This includes the following fixes:

Nicolas Pitre (1):
      [ARM] Kirkwood: restrict the scope of the PCIe reset workaround

Simon Guinot (2):
      [ARM] Kirkwood: enhance TCLK detection
      [ARM] Kirkwood: fix timer initialization for LaCie boards

 arch/arm/mach-kirkwood/common.c            |    7 +++----
 arch/arm/mach-kirkwood/d2net_v2-setup.c    |    2 +-
 arch/arm/mach-kirkwood/lacie_v2-common.c   |   14 --------------
 arch/arm/mach-kirkwood/lacie_v2-common.h   |    2 --
 arch/arm/mach-kirkwood/netspace_v2-setup.c |    6 +++---
 arch/arm/mach-kirkwood/netxbig_v2-setup.c  |    4 ++--
 arch/arm/mach-kirkwood/ts41x-setup.c       |   14 +++++++++++++-
 arch/arm/plat-orion/include/plat/pcie.h    |    3 +++
 arch/arm/plat-orion/pcie.c                 |    5 -----
 9 files changed, 25 insertions(+), 32 deletions(-)


Nicolas
