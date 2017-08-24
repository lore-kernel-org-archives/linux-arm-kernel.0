From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 24 Aug 2017 10:16:35 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.14 (#3)
Message-ID: <87d17ll6sc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt64 for mvebu for v4.14. There is
a single patch patch but an important one in it. It should have been
part of the previous PR but I missed the second version of this patch
as I was on the road for the holiday. Sorry for this late PR.

Gregory

The following changes since commit 0ea62502a5146cfe98696a152894ebb9afbee9d4:

  ARM64: dts: marvell: enable USB host on Armada-8040-DB (2017-08-14 16:30:43 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.14-3

for you to fetch changes up to bf32f2aeb2f73b7e5cee3c95f232ae5af97d45f6:

  arm64: dts: marvell: add Device Tree files for Armada-8KP (2017-08-24 09:56:41 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.14 (part 3)

Add description for a new family SoC from Marvell: Armada-8KP.

----------------------------------------------------------------
Hanna Hawa (1):
      arm64: dts: marvell: add Device Tree files for Armada-8KP

 .../devicetree/bindings/arm/marvell/armada-8kp.txt |  15 ++
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     |  67 +++++++++
 arch/arm64/boot/dts/marvell/armada-8080.dtsi       |  53 +++++++
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 104 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 163 +++++++++++++++++++++
 6 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
