From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 11:10:00 +0530
Subject: [PATCH 0/6] arm64: dts: Add missing cooling device properties for CPUs
Message-ID: <cover.1527225682.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This fixes missing cooling device properties for CPUs for the ARM64
platforms. This is build tested by the zero day testing infrastructure
as well.

Individual maintainers can pick the patches to their SoC trees or I will
ask ARM SoC maintainers to pick them up later.

--
viresh

Viresh Kumar (6):
  arm64: dts: amlogic: Add missing cooling device properties for CPUs
  arm64: dts: freescale: Add missing cooling device properties for CPUs
  arm64: dts: hisilicon: Add missing cooling device properties for CPUs
  arm64: dts: mediatek: Add missing cooling device properties for CPUs
  arm64: dts: rockchip: Add missing cooling device properties for CPUs
  arm64: dts: socionext: Add missing cooling device properties for CPUs

 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  5 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  6 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |  4 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 16 ++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  3 +++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 12 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  8 ++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  2 ++
 13 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
