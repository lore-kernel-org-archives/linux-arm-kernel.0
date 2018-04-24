From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 24 Apr 2018 11:41:41 +0200
Subject: [PATCH v2 0/4] Add STM32 USBPHYC to stm32mp157c
Message-ID: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STM32 USB PHY Controller (USBPHYC) to
stm32mp157c SoC and enables it on stm32mp157c-ev1 board.

---
Changes in v2:
* Add reset dt-bindings include
* Add fixed regulators
* Enable CONFIG_PHY_STM32_USBPHYC in multi_v7_defconfig

Amelie Delaunay (4):
  ARM: dts: stm32: add USBPHYC support to stm32mp157c
  ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
  ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
  ARM: multi_v7_defconfig: enable STM32 USB PHY Controller (USBPHYC)

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 36 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts |  5 +++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 21 ++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig   |  1 +
 4 files changed, 63 insertions(+)

-- 
2.7.4
