From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 23 Jul 2015 07:24:00 +0200
Subject: [GIT PULL] STM32 DT changes for v4.3 v2
Message-ID: <55B07A70.4050902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.3 (version 2):

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-dt-for-v4.3-1b

for you to fetch changes up to 2303553f3f32cb508c7818ebfda78a13d3c10d37:

   ARM: dts: Use stdout-path in STM32F429 Discovery board (2015-07-23 
07:07:12 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.3, round 1.

Highlights:
-----------
  - Add RCC clocks support to STM32F429
  - Add STM32429i-EVAL board support
  - Use stdout-path instead of linux,stdout-path in Disco board

----------------------------------------------------------------
Daniel Thompson (1):
       ARM: dts: stm32f429: Adopt STM32F4 clock driver

Maxime Coquelin (2):
       ARM: dts: Add STM32429i-EVAL board support
       ARM: dts: Use stdout-path in STM32F429 Discovery board

  arch/arm/boot/dts/Makefile            |  4 +-
  arch/arm/boot/dts/stm32429i-eval.dts  | 75 
+++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stm32f429-disco.dts |  8 +++-
  arch/arm/boot/dts/stm32f429.dtsi      | 79 
+++++++++++------------------------
  4 files changed, 108 insertions(+), 58 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32429i-eval.dts
