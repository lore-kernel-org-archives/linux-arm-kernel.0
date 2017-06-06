From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 6 Jun 2017 18:13:30 +0200
Subject: [PATCH 0/3] Add stm32h743i-disco board
Message-ID: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This series adds basic support for the stm32h743i discovery board 
based on stm32h7 MCU.

Patrice Chotard (3):
  ARM: dts: stm32h743: Add usart2_pins
  ARM: dts: stm32h743: Add usart2 support
  ARM: dts: stm32h743: Add stm32h743i-disco board

 arch/arm/boot/dts/Makefile               |  3 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 13 ++++++
 arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++
 arch/arm/boot/dts/stm32h743i-disco.dts   | 74 ++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts

-- 
1.9.1
