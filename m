From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 15 Feb 2018 09:20:11 +0100
Subject: [PATCH 0/3] ARM: dts: stm32: Add display support on stm32f469-disco
Message-ID: <20180215082014.30383-1-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds the mipi dsi support to stm32f469 and enables it 
on the stm32f469-disco board.

Philippe CORNU (1):
  ARM: dts: stm32: Add display support on stm32f469-disco

Philippe Cornu (2):
  ARM: dts: stm32: Add dt-bindings gpio.h include on stm32f469-disco
  ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi

 arch/arm/boot/dts/stm32f469-disco.dts | 54 +++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/stm32f469.dtsi      | 19 ++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32f469.dtsi

-- 
2.15.1
