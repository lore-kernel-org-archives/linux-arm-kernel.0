From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Apr 2017 18:26:33 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.12 (#2)
Message-ID: <87y3v4uvd2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.12.

Gregory

The following changes since commit 60894719241e2b3d6d202304de9ad33a8da3685c:

  arm64: marvell: dts: add PPv2.2 description to Armada 7K/8K (2017-03-23 17:46:23 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.12-2

for you to fetch changes up to 7ba2ef7c7200e476ee2cede7bcffcf7749e02f5c:

  arm64: marvell: dts: enable the crypto engine on the Armada 8040 DB (2017-04-12 10:36:30 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.12 (part 2)

- crypto engine description for the Armada 7k/8k SoCs and the boards
  using it
- SDHCI description for the Armada 37xx and 7k/8k SoCs and the boards
  using it

----------------------------------------------------------------
Antoine Tenart (3):
      arm64: marvell: dts: add crypto engine description for 7k/8k
      arm64: marvell: dts: enable the crypto engine on the Armada 7040 DB
      arm64: marvell: dts: enable the crypto engine on the Armada 8040 DB

Gregory CLEMENT (2):
      arm64: dts: marvell: add eMMC support for Armada 37xx
      arm64: dts: marvell: add sdhci support for Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  9 ++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 11 +++++++++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 18 +++++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 16 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 11 +++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 26 ++++++++++++++++++++++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 16 +++++++++++++
 7 files changed, 107 insertions(+)
