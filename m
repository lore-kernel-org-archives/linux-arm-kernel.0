From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Jan 2015 10:25:40 -0800
Subject: [GIT PULL 3/3] omap device tree changes for v3.20, part 2
In-Reply-To: <pull-1421777718-852183>
References: <pull-1421777718-852183>
Message-ID: <pull-1421777718-852183-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7300bfff886a1340cfeb252035303e265cd556d9:

  ARM: dts: omap3-gta04: Add handling for tv output (2015-01-13 08:02:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dt-pt2

for you to fetch changes up to 1f43c45df7afb706470f7d81d983dd7763a9452f:

  ARM: dts: dra72-evm: Add qspi device (2015-01-20 10:07:25 -0800)

----------------------------------------------------------------
More changes for omap dts files mostly to add support for
dm816x devices and clocks. Also adds a qspi device for
dra72x-evm.

----------------------------------------------------------------
Mugunthan V N (1):
      ARM: dts: dra72-evm: Add qspi device

Tony Lindgren (3):
      ARM: dts: Add basic dm816x device tree configuration
      ARM: dts: Add basic clocks for dm816x
      ARM: dts: Add minimal support for dm8168-evm

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/dm8168-evm.dts     | 129 ++++++++++++
 arch/arm/boot/dts/dm816x-clocks.dtsi | 250 ++++++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi        | 387 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts      |  77 +++++++
 include/dt-bindings/pinctrl/omap.h   |   1 +
 6 files changed, 845 insertions(+)
 create mode 100644 arch/arm/boot/dts/dm8168-evm.dts
 create mode 100644 arch/arm/boot/dts/dm816x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dm816x.dtsi
