From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jun 2015 15:57:15 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.2
Message-ID: <5592A03B.5020900@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a small pull request for fixes for mvebu for v4.2.
It would be nice to have them in v4.2-rc1. It combines two signed
tags: the new one mvebu-fixes-4.2-0 and the previous one which has not
been pulled for 4.1: mvebu-fixes-4.1-4

Gregory

The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:

  Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.2-0

for you to fetch changes up to 5d6bed2a9c8bc161bff4cc7cede00f2e0e27a7e7:

  ARM: dove: fix legacy dove IRQ numbers (2015-06-24 11:05:57 +0200)

----------------------------------------------------------------
mvebu fixes for 4.2 (part 0)

Fix legacy dove IRQ numbers

----------------------------------------------------------------
Russell King (1):
      ARM: dove: fix legacy dove IRQ numbers

Thomas Petazzoni (1):
      ARM: mvebu: fix suspend to RAM on big-endian configurations

 arch/arm/mach-dove/include/mach/irqs.h | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------
 arch/arm/mach-dove/irq.c               |   8 ++++----
 arch/arm/mach-mvebu/pm-board.c         |   3 +++
 3 files changed, 66 insertions(+), 63 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
