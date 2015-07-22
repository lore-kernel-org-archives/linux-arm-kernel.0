From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 19:12:17 +0200
Subject: [GIT PULL] STM32 DT changes for v4.3
Message-ID: <55AFCEF1.5070604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.3:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-dt-for-v4.3-1

for you to fetch changes up to cf790d592e296233fafff89ca564a243a169ee1c:

   ARM: dts: Add STM32429i-EVAL board support (2015-07-12 11:27:36 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.3, round 1.

Highlights:
-----------
  - Add RCC clocks support to STM32F429
  - Add STM32429i-EVAL board support

----------------------------------------------------------------
Daniel Thompson (1):
       ARM: dts: stm32f429: Adopt STM32F4 clock driver

Maxime Coquelin (1):
       ARM: dts: Add STM32429i-EVAL board support

  arch/arm/boot/dts/Makefile            |  4 +-
  arch/arm/boot/dts/stm32429i-eval.dts  | 75 
+++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stm32f429-disco.dts |  4 ++
  arch/arm/boot/dts/stm32f429.dtsi      | 79 
+++++++++++------------------------
  4 files changed, 106 insertions(+), 56 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32429i-eval.dts
