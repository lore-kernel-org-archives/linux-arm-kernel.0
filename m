From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 16:54:37 +0100
Subject: [PATCH 0/3] USB OTG on STM32F7 boards
Message-ID: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for Peripheral mode on stm32f746 by adding
dwc2 gadget fifo sizes and enables USB OTG HS in OTG (DRD) mode on
stm32746g-eval and stm32f769-disco. It possible to use OTG HS in
Peripheral or Host mode, depending on the USB connector.

Amelie Delaunay (3):
  ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
  ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
  ARM: dts: stm32: enable USB HS on stm32f769-disco

 arch/arm/boot/dts/stm32746g-eval.dts  |  2 +-
 arch/arm/boot/dts/stm32f746.dtsi      |  3 +++
 arch/arm/boot/dts/stm32f769-disco.dts | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4
