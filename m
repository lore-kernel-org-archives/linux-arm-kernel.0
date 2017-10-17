From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 17 Oct 2017 12:16:13 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.15 #1
Message-ID: <8c7fe79d-ebd3-ee7c-f056-1d3aa225edee@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 defconfig updates for v4.15:

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.15-1

for you to fetch changes up to 4a95602b3edf656ff4540bd62057901d4bb33812:

   ARM: configs: stm32: Add MDMA support in STM32 defconfig (2017-10-16 
18:25:20 +0200)

----------------------------------------------------------------
STM32 defconfig updates for v4.15, round 1

Highlights:
----------
  -Regenerate default configuration
  -Add DMAMUX support
  -Add I2C F7 support
  -Add MDMA support

----------------------------------------------------------------
Alexandre Torgue (1):
       ARM: configs: stm32: Update default configuration for v4.14-rc1

Pierre-Yves MORDRET (3):
       ARM: configs: stm32: Add DMAMUX support in STM32 defconfig
       ARM: configs: stm32: Add I2C F7 support in STM32 defconfig
       ARM: configs: stm32: Add MDMA support in STM32 defconfig

  arch/arm/configs/stm32_defconfig | 11 +++++------
  1 file changed, 5 insertions(+), 6 deletions(-)
