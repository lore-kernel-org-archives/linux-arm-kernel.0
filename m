From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Feb 2016 14:16:58 +0000
Subject: [PATCH 0/3] ARM: stm32: Introduce support for STM32F469
Message-ID: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simple set using the STM32F429 infrastructure as a foundation.
There will be more changes to the DTS files and a requirement for
added hierarchical layering as more differences become apparent.

Lee Jones (3):
  ARM: stm32: Supply a DTS file for the STM32F469 Discovery board
  ARM: configs: Add new config fragment to change RAM start point
  ARM: stm32: Identify a new board - STM32F469

 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/stm32f469-disco.dts   | 75 +++++++++++++++++++++++++++++++++
 arch/arm/configs/dram_0x00000000.config |  1 +
 arch/arm/mach-stm32/board-dt.c          |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32f469-disco.dts
 create mode 100644 arch/arm/configs/dram_0x00000000.config

-- 
1.9.1
