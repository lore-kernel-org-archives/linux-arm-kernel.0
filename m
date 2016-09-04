From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 04 Sep 2016 17:57:29 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.9 (#1)
Message-ID: <87h99vzmhi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.9-1

for you to fetch changes up to 98e45c1675a018e1121c1244985cf80b790fb6c4:

  arm64: dts: marvell: describe the PIC and PMU on Armada 7K/8K (2016-08-26 10:57:20 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.9 (part 1)

- add description for the new Armada 8040 dev board
- add the PIC and PMU on Armada 7K/8K

----------------------------------------------------------------
Thomas Petazzoni (3):
      arm64: dts: marvell: add description for the slave CP110 in Armada 8K
      arm64: dts: marvell: add description for the Armada 8040 dev board
      arm64: dts: marvell: describe the PIC and PMU on Armada 7K/8K

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 150 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  14 ++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 246 +++++++++++++++++++++
 6 files changed, 413 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
