From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 17:33:12 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.9 (#2)
Message-ID: <87d1k6bio7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.9.

This one is not related to the convert orion5x based SoC Netgear WNR854T
to devicetree, but it is just a small update on the device tree.

Gregory

The following changes since commit 98e45c1675a018e1121c1244985cf80b790fb6c4:

  arm64: dts: marvell: describe the PIC and PMU on Armada 7K/8K (2016-08-26 10:57:20 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.9-2

for you to fetch changes up to 93970e67bdaec174ba8dad93e5ebb55be98f8d61:

  arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K (2016-09-14 16:21:09 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.9 (part 2)

- enable MSI for PCIe on Armada 7K/8K

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +++
 2 files changed, 6 insertions(+)
