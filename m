From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Mar 2018 12:15:06 +0100
Subject: [GIT PULL] STM32 SOC changes for v4.17 #1
Message-ID: <d283d515-5f73-2207-9ed7-d554ddb673ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 SOC updates for v4.17:

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-soc-for-v4.17-1

for you to fetch changes up to 2092e3adc323695255bd06d65f14c89afb5727ae:

   ARM: stm32: restore reboot capabilities (2018-03-05 09:11:58 +0100)

----------------------------------------------------------------
STM32 SOC updates for v4.17, round 1.

Highlights:
----------
  -Add STM32F769 MCU support
  -Add STM32MP157 MPU support
  -Add AMBA PL180 MMCI support for F4 and F7 MCUs
  -Move STM32 documentation to rst format

----------------------------------------------------------------
Alexandre Torgue (2):
       ARM: stm32: Kconfig: introduce MACH_STM32F769 flag
       ARM: stm32: add new STM32F769 MCU

Benjamin Gaignard (2):
       ARM: stm32: Fix copyright
       ARM: stm32: restore reboot capabilities

Ludovic Barre (3):
       Documentation: arm: stm32: move to rst format
       ARM: stm32: prepare stm32 family to welcome armv7 architecture
       ARM: stm32: add initial support for STM32MP157

Patrice Chotard (1):
       ARM: stm32: Add AMBA support for STM32F4 and STM32F7 SoCs

  Documentation/arm/stm32/overview.rst            | 34 ++++++++++++++++++
  Documentation/arm/stm32/overview.txt            | 33 ------------------
  Documentation/arm/stm32/stm32f429-overview.rst  | 26 ++++++++++++++
  Documentation/arm/stm32/stm32f429-overview.txt  | 22 ------------
  Documentation/arm/stm32/stm32f746-overview.rst  | 33 ++++++++++++++++++
  Documentation/arm/stm32/stm32f746-overview.txt  | 34 ------------------
  Documentation/arm/stm32/stm32f769-overview.rst  | 35 +++++++++++++++++++
  Documentation/arm/stm32/stm32h743-overview.rst  | 34 ++++++++++++++++++
  Documentation/arm/stm32/stm32h743-overview.txt  | 30 ----------------
  Documentation/arm/stm32/stm32mp157-overview.rst | 19 ++++++++++
  arch/arm/mach-stm32/Kconfig                     | 46 
++++++++++++++++++-------
  arch/arm/mach-stm32/board-dt.c                  | 11 ++++--
  12 files changed, 224 insertions(+), 133 deletions(-)
  create mode 100644 Documentation/arm/stm32/overview.rst
  delete mode 100644 Documentation/arm/stm32/overview.txt
  create mode 100644 Documentation/arm/stm32/stm32f429-overview.rst
  delete mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
  create mode 100644 Documentation/arm/stm32/stm32f746-overview.rst
  delete mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
  create mode 100644 Documentation/arm/stm32/stm32f769-overview.rst
  create mode 100644 Documentation/arm/stm32/stm32h743-overview.rst
  delete mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
  create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst
