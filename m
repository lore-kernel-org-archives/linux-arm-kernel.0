From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 18 Jun 2015 21:51:35 +0200
Subject: [GIT PULL] ARM: mvebu: fixes changes for v4.1
Message-ID: <55832147.1020202@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the forth pull request for fixes for mvebu for v4.1.

Actually this bug can happen only on one board: the Armada XP GP,
so if you can't pull it for 4.1, I will send it again once 4.2-rc1
will be released.

Gregory

The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:

  Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.1-4

for you to fetch changes up to 2f5bc307be2480ba89e4c5d118f406f04a4a7299:

  ARM: mvebu: fix suspend to RAM on big-endian configurations (2015-06-17 17:23:36 +0200)

----------------------------------------------------------------
mvebu fixes for 4.1 (part 4)

Fix suspend to RAM on big-endian configurations on Armada XP GP board

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: fix suspend to RAM on big-endian configurations

 arch/arm/mach-mvebu/pm-board.c | 3 +++
 1 file changed, 3 insertions(+)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
