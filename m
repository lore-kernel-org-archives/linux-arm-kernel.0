From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 17:03:21 +0100
Subject: [PATCH 0/3] USB OTG on STM32H743
Message-ID: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for USB OTG HS and FS on stm32h743 SoC.
It also enables USB OTG HS on stm32h743i-eval board in OTG (DRD) mode. It is
possible to use OTG HS in Peripheral or Host mode depending on the USB
connector.

Amelie Delaunay (3):
  ARM: dts: stm32: add USB OTG HS support for STM32H743 SoC
  ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
  ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval

 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.7.4
