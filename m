From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 19 Sep 2010 23:04:27 -0400 (EDT)
Subject: Git pull request for 2.6.36-rc
Message-ID: <alpine.LFD.2.00.1009192255500.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull the following:

   git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git for-rmk

This contains the following fixes for Kirkwood/Dove platforms:

Arnaud Patard (1):
      ARM: kirkwood: Unbreak PCIe I/O port

Eric Miao (1):
      ARM: dove: fix __io() definition to use bus based offset

Simon Guinot (2):
      dmaengine: fix interrupt clearing for mv_xor
      leds: leds-ns2: fix locking

 arch/arm/mach-dove/include/mach/io.h           |    6 +++---
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    2 +-
 arch/arm/mach-kirkwood/pcie.c                  |    4 ++--
 drivers/dma/mv_xor.c                           |    2 +-
 drivers/leds/leds-ns2.c                        |    9 +++++----
 5 files changed, 12 insertions(+), 11 deletions(-)


Nicolas
