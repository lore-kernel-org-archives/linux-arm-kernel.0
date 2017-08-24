From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Thu, 24 Aug 2017 18:27:50 +0800
Subject: [PATCH 0/5] thermal: rockchip: add tsadc support in thermal driver
 and IPA thermal control for RV1108 in dts
Message-ID: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches add the tsadc support in thermal driver and in devicetree for RV1108.
Also add thermal control with Intelligent Power Allocation (IPA) policy by default.  Please
refer to https://developer.arm.com/open-source/intelligent-power-allocation for more information
about IPA.

Rocky Hao (5):
  dt-bindings: rockchip-thermal: Support the RV1108 SoC compatible
  thermal: rockchip: Support the RV1108 SoC in thermal driver
  arm: dts: rockchip: add tsadc node for RV1108 SoC
  arm: dts: rockchip: add thermal nodes for RV1108 SoC
  arm: dts: rockchip: enable tsadc module on RV1108 evaluation board

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 arch/arm/boot/dts/rv1108-evb.dts                   |  4 ++
 arch/arm/boot/dts/rv1108.dtsi                      | 69 ++++++++++++++++++++++
 drivers/thermal/rockchip_thermal.c                 | 67 +++++++++++++++++++++
 4 files changed, 141 insertions(+)

-- 
1.9.1
