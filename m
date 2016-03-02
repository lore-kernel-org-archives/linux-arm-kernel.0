From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 2 Mar 2016 11:53:23 +0100
Subject: [GIT PULL] STM32 defconfig updates for v4.6 #1
Message-ID: <56D6C623.8030908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 defconfig updates for v4.6:

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-defconfig-for-v4.6-1

for you to fetch changes up to 9fe5bf92c30a89631eb1fafe0d9b18e2ba331ebb:

   ARM: configs: Add new config fragment to change RAM start point 
(2016-02-17 17:31:30 +0100)

----------------------------------------------------------------
Highlights:
-----------
  - Enable GPIO led driver in stm32_defconfig
  - Introduce a config fragment to override RAM base address

----------------------------------------------------------------
Lee Jones (1):
       ARM: configs: Add new config fragment to change RAM start point

Maxime Coquelin (1):
       ARM: config: Enable GPIO Led driver in stm32_defconfig

  arch/arm/configs/dram_0x00000000.config | 1 +
  arch/arm/configs/stm32_defconfig        | 1 +
  2 files changed, 2 insertions(+)
  create mode 100644 arch/arm/configs/dram_0x00000000.config
