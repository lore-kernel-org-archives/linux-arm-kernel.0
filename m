From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Mar 2017 18:24:07 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.12 (#1)
Message-ID: <87h92ibnbc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.12.

Gregory

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.12-1

for you to fetch changes up to 60894719241e2b3d6d202304de9ad33a8da3685c:

  arm64: marvell: dts: add PPv2.2 description to Armada 7K/8K (2017-03-23 17:46:23 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.12 (part 1)

- Add RTC support on Armada 7k/8k
- Improve i2c support on Armada 37xx
- Add gpio expander and RTC on Armada 3720 board
- Improve USB3 support on Armada 37xx
- Add network support on Armada 7k/8k

----------------------------------------------------------------
Gregory CLEMENT (7):
      arm64: dts: marvell: add RTC description for Armada 7K/8K
      ARM64: dts: marvell: armada37xx: add address and size property for i2c cells
      ARM64: dts: marvell: armada-3720-db: add gpio expander
      ARM64: dts: marvell: armada-37xx: Fix interrupt mapping for USB3
      ARM64: dts: marvell: armada-37xx: Add clock resource for USB3
      ARM64: dts: marvell: armada-3720-db: Add phy for USB3
      ARM64: dts: marvell: armada-3720 add RTC support

Thomas Petazzoni (1):
      arm64: marvell: dts: add PPv2.2 description to Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 41 ++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  7 +++-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 25 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       | 10 +++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 16 ++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |  9 +++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 44 ++++++++++++++++++++++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 44 ++++++++++++++++++++++
 8 files changed, 195 insertions(+), 1 deletion(-)
