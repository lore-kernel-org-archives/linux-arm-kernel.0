From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Nov 2016 22:51:19 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.10 (#1)
Message-ID: <87oa1dbwrs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.10.

Here again, I hope being able to send a second part very soon with the
series removing all the remaining DT warning.

Gregory

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.10-1

for you to fetch changes up to e735aaf8fc4ac84dbdb3642a135da8dcdb84587b:

  arm64: dts: marvell: Add definition for the Globalscale Marvell ESPRESSOBin Board (2016-10-17 17:19:56 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.10 (part 1)

Adding the new "community" board for Armada 3700

----------------------------------------------------------------
Romain Perier (1):
      arm64: dts: marvell: Add definition for the Globalscale Marvell ESPRESSOBin Board

 arch/arm64/boot/dts/marvell/Makefile               |  1 +
 .../boot/dts/marvell/armada-3720-espressobin.dts   | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
