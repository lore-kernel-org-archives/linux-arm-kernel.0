From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Aug 2016 13:00:05 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.8 (#2)
Message-ID: <87d1kviymi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.8.

Gregory

The following changes since commit d9fd3c918114cfd3995947339549c7341181efb0:

  ARM: dts: armada-388-clearfog: number LAN ports properly (2016-08-08 13:20:24 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.8-2

for you to fetch changes up to c721da1d05760ad0b4e7670896dae31b6b07d8d6:

  ARM: dts: kirkwood: Fix PCIe label on OpenRD (2016-08-26 11:33:16 +0200)

----------------------------------------------------------------
mvebu fixes for 4.8 (part 1)

Few device tree fix on kirkwood:
- enable PCIe on OpenRD
- use correct u-boot environment partition size on ib62x0

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: dts: kirkwood: Fix PCIe label on OpenRD

Simon Baatz (1):
      ARM: kirkwood: ib62x0: fix size of u-boot environment partition

 arch/arm/boot/dts/kirkwood-ib62x0.dts  | 2 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
