From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Nov 2016 09:45:05 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.10 (#2)
Message-ID: <8737inamem.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.10.

This series was posted 2 weeks ago and actually should have been part
of the first PR.

Gregory

The following changes since commit e735aaf8fc4ac84dbdb3642a135da8dcdb84587b:

  arm64: dts: marvell: Add definition for the Globalscale Marvell ESPRESSOBin Board (2016-10-17 17:19:56 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.10-2

for you to fetch changes up to 3684534548d4cbba7d3724b3d79152eff38dc82f:

  ARM64: dts: marvell: Fixup memory DT warning for Armada 37xx (2016-11-19 09:39:07 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.10 (part 2)

Fix DTC warning on Armada 37xx and 7K/8K

----------------------------------------------------------------
Gregory CLEMENT (3):
      arm64: dts: marvell: Fixup internal-regs DT warning for Armada 37xx
      arm64: dts: marvell: Fixup config-space DT warning For Armada 7K/8K
      ARM64: dts: marvell: Fixup memory DT warning for Armada 37xx

 arch/arm64/boot/dts/marvell/armada-3720-db.dts          | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi           | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi    | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
