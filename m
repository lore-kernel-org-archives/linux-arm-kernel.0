From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Aug 2017 11:52:48 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.14 (#4)
Message-ID: <87k21l4c27.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the forth (and ultimate) pull request for dt64 for mvebu for v4.14.

I really hope it is not too late.

These patches were initially part of the netdev series but were
removed from these series to avoid conflict in the device
tree. Unfortunately this moved was done during the holiday time so
it didn't happen smoothly. I will do better for the next release.

They really worth to be added because all the driver part were already
there but as pointed by Thomas otherwise the driver changes are
somewhat useless.

Thanks!


Gregory

The following changes since commit bf32f2aeb2f73b7e5cee3c95f232ae5af97d45f6:

  arm64: dts: marvell: add Device Tree files for Armada-8KP (2017-08-24 09:56:41 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.14-4

for you to fetch changes up to 72af17b9a8caa1fd373c7615cdfef5ee10e20577:

  arm64: dts: marvell: mcbin: enable more networking ports (2017-08-30 11:37:06 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.14 (part 4)

Adding more resources on the network controller ppv2.2 on Armada 7K/8K
allowing to use last improvement introduced in the driver.

Also enabling more network ports on the mcbin (A8K base board)

----------------------------------------------------------------
Antoine Tenart (2):
      arm64: dts: marvell: add a reference to the sysctrl syscon in the ppv2 node
      arm64: dts: marvell: mcbin: enable more networking ports

Thomas Petazzoni (1):
      arm64: dts: marvell: add TX interrupts for PPv2.2

 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 30 ++++++++++++++++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 25 +++++++++++++++---
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 25 +++++++++++++++---
 3 files changed, 74 insertions(+), 6 deletions(-)
