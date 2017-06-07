From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 7 Jun 2017 09:16:20 +0200
Subject: [PATCH 0/3] Add stm32h743i-disco board
Message-ID: <1496819783-5113-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This series adds basic support for the stm32h743i discovery board 
based on stm32h7 MCU.

v2:	_ update commit messages header with format "ARM: dts: stm32: ...."

Patrice Chotard (3):
  ARM: dts: stm32: Add usart2_pins on stm32h743.
  ARM: dts: stm32: Add usart2 support on stm32h743.
  ARM: dts: stm32: Add stm32h743i-disco board

 arch/arm/boot/dts/Makefile               |  3 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 13 ++++++
 arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++
 arch/arm/boot/dts/stm32h743i-disco.dts   | 73 ++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts

-- 
1.9.1
