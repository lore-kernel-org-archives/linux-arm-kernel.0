From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:33:21 +0100
Subject: [PATCH 0/4] dt/bindings & ARM: dts: tegra: updates
Message-ID: <20180210013326.27771-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series fixes the Tegra GMI controller DT/bindings example, a few
IRQ type definitions, removes some invalid uses of rsvd1 pin muxes on
Beaver and removes a duplicate pcie-1 node on Venice2.


Marcel Ziswiler (4):
  dt/bindings: fix binding examples for tegra gmi controller
  ARM: dts: tegra: use proper irq type definitions
  ARM: dts: tegra: beaver: remove invalid uses of rsvd1
  ARM: dts: tegra: venice2: remove duplicate pcie-1 node

 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  6 ++--
 arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  9 ++----
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  4 +--
 arch/arm/boot/dts/tegra30-beaver.dts               | 32 +++++++++++-----------
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  2 +-
 7 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.14.3
