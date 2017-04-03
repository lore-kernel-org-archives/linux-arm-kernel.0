From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 3 Apr 2017 19:25:40 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.12 #1
Message-ID: <76224fca-01aa-1aa4-3d84-36cfaaa21567@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 defconfig updates for v4.12:

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.12-1

for you to fetch changes up to a1365c4081ac21d2a51fcde3a9956e0e41cc2b74:

   ARM: configs: Add new config fragment to change RAM start point 
(2017-03-31 14:19:40 +0200)

----------------------------------------------------------------
STM32 defconfig updates for v4.12, round 1.

Highlights:
----------
  - Enable I2C
  - Add config fragment for RAM start point

----------------------------------------------------------------
Alexandre TORGUE (1):
       ARM: configs: Add new config fragment to change RAM start point

M'boumba Cedric Madianga (1):
       ARM: configs: stm32: Add I2C support

  arch/arm/configs/dram_0xd0000000.config | 1 +
  arch/arm/configs/stm32_defconfig        | 3 +++
  2 files changed, 4 insertions(+)
  create mode 100644 arch/arm/configs/dram_0xd0000000.config
