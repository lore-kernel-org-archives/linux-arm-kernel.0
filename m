From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Fri,  4 Aug 2017 16:06:11 +0800
Subject: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal driver
 and IPA thermal control for rk3328 in dts
Message-ID: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches add the tsadc support in thermal driver and in devicetree for rk3328.
Also add thermal control with Intelligent Power Allocation (IPA) policy by default.  Please
refer to https://developer.arm.com/open-source/intelligent-power-allocation for more information
about IPA.

Rocky Hao (5):
  dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
  thermal: rockchip: Support the RK3328 SOC in thermal driver
  arm64: dts: rockchip: add tsadc node for rk3328 SoC
  arm64: dts: rockchip: add thermal nodes for rk3328 SoC
  arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation board

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  4 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 63 +++++++++++++++++++++
 drivers/thermal/rockchip_thermal.c                 | 65 ++++++++++++++++++++++
 4 files changed, 133 insertions(+)

-- 
1.9.1
