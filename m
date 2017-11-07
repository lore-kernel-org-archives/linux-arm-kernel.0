From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Nov 2017 16:14:47 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.15 (#2)
Message-ID: <87a7zy6ryw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.15.

These last pull request appears only now because the uart driver was
just merged a couple of days ago.

Gregory

The following changes since commit c4e3bf290c3089502ee33e25795075b86fe9a449:

  arm64: dts: marvell: 7040-db: Add the carrier detect pin for SD card on CP (2017-10-12 15:53:47 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.15-2

for you to fetch changes up to c3c08c5d32d819a73f75a76b315e229a2081680a:

  arm64: dts: marvell: armada-3720-espressobin: fill UART nodes (2017-10-30 15:56:34 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.15 (part 2)

Add the extended UART support on Armada 3700

----------------------------------------------------------------
Miquel Raynal (4):
      arm64: dts: marvell: armada-37xx: add UART clock
      arm64: dts: marvell: armada-37xx: add second UART port
      arm64: dts: marvell: armada-3720-db: enable second UART port
      arm64: dts: marvell: armada-3720-espressobin: fill UART nodes

 arch/arm64/boot/dts/marvell/armada-3720-db.dts        |  9 ++++++++-
 .../boot/dts/marvell/armada-3720-espressobin.dts      | 12 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi          | 19 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 2 deletions(-)
