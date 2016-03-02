From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 2 Mar 2016 11:53:32 +0100
Subject: [GIT PULL] STM32 DT updates for v4.6 #2
Message-ID: <56D6C62C.5070206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STM32 DT updates for v4.6:

The following changes since commit b2aa7f7741f511c6a1ea266d62d203662f121ea7:

   ARM: dts: stm32f429: Boost perfs by remapping SDRAM Bank 1 to 0x0 
(2016-02-11 12:02:59 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-dt-for-v4.6-2

for you to fetch changes up to 13759544fe17a5f179ce17163fd15b0ebd25b0ad:

   ARM: dts: stm32f429: Enable Ethernet on Eval board (2016-03-02 
10:26:55 +0100)

----------------------------------------------------------------
Highlights:
-----------
  - Fix clock references in GPIO nodes
  - Add early support to stm32f469 MCU
  - Add USB HS support in host mdoe to stm32429-eval board
  - Add Ethernet support to stm32429-eval board

----------------------------------------------------------------
Alexandre TORGUE (3):
       ARM: dts: stm32f429: Add system config bank node
       ARM: dts: stm32f429: Add Ethernet support
       ARM: dts: stm32f429: Enable Ethernet on Eval board

Lee Jones (1):
       ARM: stm32: Supply a DTS file for the STM32F469 Discovery board

Maxime Coquelin (2):
       ARM: dts: stm32f429: Fix clocks referenced by GPIO banks
       ARM: dts: stm32429i-eval: Add USB HS host mode support

  arch/arm/boot/dts/Makefile            |  1 +
  arch/arm/boot/dts/stm32429i-eval.dts  | 31 ++++++++++++
  arch/arm/boot/dts/stm32f429.dtsi      | 92 
++++++++++++++++++++++++++++++-----
  arch/arm/boot/dts/stm32f469-disco.dts | 75 ++++++++++++++++++++++++++++
  4 files changed, 188 insertions(+), 11 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32f469-disco.dts
