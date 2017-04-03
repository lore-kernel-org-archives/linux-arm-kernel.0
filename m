From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 3 Apr 2017 19:23:33 +0200
Subject: [GIT PULL] STM32 SOC changes for v4.12 #1
Message-ID: <a7b21384-ec29-c39f-97a8-579ca8d16bc2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 SOC updates for v4.12:

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-soc-for-v4.12-1

for you to fetch changes up to c6ed0f31ce3e1c5729d1c8f81a2a94ab881506a6:

   ARM: stm32: Add a new SOC - STM32H743 (2017-03-24 11:37:24 +0100)

----------------------------------------------------------------
STM32 SOC updates for v4.12, round 1.

Highlights:
----------
  - Create a dedicated Kconfig for STM32 machine
  - Add support of STM32H743 MCU

----------------------------------------------------------------
Alexandre TORGUE (3):
       ARM: stm32: create dedicated kconfig for STM32 machine
       ARM: stm32: Introduce MACH_STM32H743 flag
       ARM: stm32: Add a new SOC - STM32H743

  Documentation/arm/stm32/stm32h743-overview.txt | 30 
++++++++++++++++++++++++++
  arch/arm/Kconfig                               | 24 ++-------------------
  arch/arm/mach-stm32/Kconfig                    | 26 ++++++++++++++++++++++
  arch/arm/mach-stm32/board-dt.c                 |  1 +
  4 files changed, 59 insertions(+), 22 deletions(-)
  create mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
  create mode 100644 arch/arm/mach-stm32/Kconfig
