From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Nov 2009 19:12:28 -0500 (EST)
Subject: Git pull request: another Kirkwood fix for 2.6.32-rc7
Message-ID: <alpine.LFD.2.00.0911131904580.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull:

	git://git.marvell.com/orion for-rmk

This contains a single patch that missed the previous pull request.

Lennert Buytenhek (1):
      [ARM] Kirkwood: disable propagation of mbus error to the CPU local bus

 arch/arm/mach-kirkwood/common.c                   |    8 ++++++++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)


Nicolas
