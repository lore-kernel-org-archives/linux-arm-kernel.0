From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 11 Feb 2016 14:22:05 +0100
Subject: [GIT PULL] STM32 SoC updates for v4.6 #1
Message-ID: <56BC8AFD.7000800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 SoC updates for v4.6:

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-soc-for-v4.6-1

for you to fetch changes up to f64e980450027e15dce5e9ec4ee19bab98aee4c5:

   ARM: mach-stm32: Select pinctrl (2016-01-27 19:45:57 +0100)

----------------------------------------------------------------
Highlights:
-----------
  - Make STM32 to select PINCTRL
  - Introduce MACH_STM32F429 flag

----------------------------------------------------------------
Maxime Coquelin (2):
       ARM: Kconfig: Introduce MACH_STM32F429 flag
       ARM: mach-stm32: Select pinctrl

  arch/arm/Kconfig | 6 ++++++
  1 file changed, 6 insertions(+
