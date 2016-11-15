From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 15 Nov 2016 15:40:24 +0100
Subject: [GIT PULL] STM32 DT changes for v4.10 #2
Message-ID: <2f793efd-01c6-fa28-0332-9e292341c064@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STM32 DT updates for v4.10:

The following changes since commit f6dbbff4f0af1a5c0d6eaf414572b5eff7a73a8b:

   ARM: dts: stm32f429: add LSI and LSE clocks (2016-11-04 15:08:08 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.10-2

for you to fetch changes up to 2ecaa477b404d707bac93c56f09a0a6162e04ed7:

   ARM: dts: stm32f429: Add QSPI clock (2016-11-15 13:59:11 +0100)

----------------------------------------------------------------
STM32 DT updates for v4.10, round 2.

Highlights:
----------
  - Add support of STM32F746 MCU and STM32746G-Eval board
  - Add QSPI support for STM32F469-Disco board

----------------------------------------------------------------
Alexandre TORGUE (1):
       ARM: dts: Add STM32F746 MCU and STM32746g-EVAL board

Gabriel Fernandez (1):
       ARM: dts: stm32f429: Add QSPI clock

  arch/arm/boot/dts/Makefile            |   3 +-
  arch/arm/boot/dts/stm32746g-eval.dts  |  96 +++++++++++
  arch/arm/boot/dts/stm32f469-disco.dts |   4 +
  arch/arm/boot/dts/stm32f746.dtsi      | 304 
++++++++++++++++++++++++++++++++++
  4 files changed, 406 insertions(+), 1 deletion(-)
  create mode 100644 arch/arm/boot/dts/stm32746g-eval.dts
  create mode 100644 arch/arm/boot/dts/stm32f746.dtsi
