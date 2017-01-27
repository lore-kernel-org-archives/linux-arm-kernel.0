From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 18:07:56 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.11 (#2)
Message-ID: <87k29gwhw3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.11.

Gregory

The following changes since commit 58a748f7dc29d8a7bb74c6cbba6a82425dbba5cc:

  ARM64: dts: marvell: Correct license text (2017-01-03 16:24:34 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.11-2

for you to fetch changes up to 7292ff67b9b28feb3bef97b437f08c7e7568786f:

  arm64: dts: marvell: add generic-ahci compatibles for CP110 ahci (2017-01-27 11:13:01 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.11 (part 2)

- Add a new Armada 8K based board: MACCHIATOBin
- Enable AHCI on the Armada 7K/8K SoCs

----------------------------------------------------------------
Russell King (2):
      arm64: dts: marvell: Add DT for MACCHIATOBin board
      arm64: dts: marvell: add generic-ahci compatibles for CP110 ahci

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 138 +++++++++++++++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   3 +-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   3 +-
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
