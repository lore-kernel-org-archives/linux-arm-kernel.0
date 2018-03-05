From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Mar 2018 12:18:16 +0100
Subject: [GIT PULL] STM32 defconfig changes for v4.17 #1
Message-ID: <04188a3b-6432-3e2e-8e4a-fb5522a1c8aa@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 defconfig updates for v4.17:

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.17-1

for you to fetch changes up to 1c92d4a0edcfff0fee78ade27eb41ce3fc0d071a:

   ARM: configs: stm32: Enable MMC_ARMMMCI and EXT3_FS support 
(2018-02-27 11:00:49 +0100)

----------------------------------------------------------------
STM32 defconfig updates for v4.17, round 1

Highlights:
----------
  -Add STM32 support (for MPU) to multi-v7-defconfig
  -Enable MMCI and EXT3_FS support

----------------------------------------------------------------
Ludovic Barre (1):
       ARM: configs: multi_v7: add stm32 support

Patrice Chotard (1):
       ARM: configs: stm32: Enable MMC_ARMMMCI and EXT3_FS support

  arch/arm/configs/multi_v7_defconfig | 3 +++
  arch/arm/configs/stm32_defconfig    | 3 +++
  2 files changed, 6 insertions(+)
