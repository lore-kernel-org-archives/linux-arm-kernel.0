From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Dec 2017 11:51:35 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.16 (#1)
Message-ID: <87po77doi0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.16.

Gregory

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.16-1

for you to fetch changes up to 4cada03801992d09ccceaf5f462e9dadb75a9613:

  ARM64: dts: marvell: Add thermal support for A7K/A8K (2017-12-18 17:13:17 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.16 (part 1)

Add the NAND support on the Marvell 8040-DB board
Add the thermal support for Martvell A7K/A8K Socs
Add nodes allowing cpufreq support on Aramda 3700 SoCs

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support

Miquel Raynal (2):
      arm64: dts: marvell: add NAND support on the 8040-DB board
      ARM64: dts: marvell: Add thermal support for A7K/A8K

 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  7 ++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       | 17 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  6 +++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  6 +++++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  9 ++++++-
 7 files changed, 73 insertions(+), 1 deletion(-)
