From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 2 Mar 2016 11:52:54 +0100
Subject: [GIT PULL] STM32 SoC updates for v4.6 #2
Message-ID: <56D6C606.7070107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STM32 SoC updates for v4.6:

The following changes since commit f64e980450027e15dce5e9ec4ee19bab98aee4c5:

   ARM: mach-stm32: Select pinctrl (2016-01-27 19:45:57 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-soc-for-v4.6-2

for you to fetch changes up to 6391503bbf4508ca97e9806b5347d3fd5d3c8c3c:

   ARM: stm32: Identify a new SoC - STM32F469 (2016-02-17 17:30:44 +0100)

----------------------------------------------------------------
Highlights:
-----------
  - Add a new stm32f469 SoC

----------------------------------------------------------------
Lee Jones (1):
       ARM: stm32: Identify a new SoC - STM32F469

  arch/arm/mach-stm32/board-dt.c | 1 +
  1 file changed, 1 insertion(+)
