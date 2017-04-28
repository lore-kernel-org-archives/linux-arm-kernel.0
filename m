From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 28 Apr 2017 17:08:40 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.12 (#3)
Message-ID: <87h9188t8n.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt64 for mvebu for v4.12.

It comes very late but the driver part has been merged just this week.

Gregory

The following changes since commit 7ba2ef7c7200e476ee2cede7bcffcf7749e02f5c:

  arm64: marvell: dts: enable the crypto engine on the Armada 8040 DB (2017-04-12 10:36:30 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.12-3

for you to fetch changes up to 6a680783aaadd168557eec695374929ac066536f:

  ARM64: dts: marvell: armada37xx: add pinctrl definition (2017-04-28 16:08:12 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.12 (part 3)

pinctrl and GPIO description for Armada 37xx SoCs

----------------------------------------------------------------
Gregory CLEMENT (2):
      ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
      ARM64: dts: marvell: armada37xx: add pinctrl definition

 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  8 +++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 73 ++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 3 deletions(-)
