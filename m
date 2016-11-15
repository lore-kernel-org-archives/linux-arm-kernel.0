From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 15 Nov 2016 15:22:30 +0100
Subject: [GIT PULL] STM32 SOC changes for v4.10 #1
Message-ID: <7e258e38-5ac9-60e8-4bc7-03acedd5e11d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 SOC updates for v4.10:

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/soc-for-4.10-1

for you to fetch changes up to 6bc18b83c0c3b5d56137a31ce98ca2802036e7a9:

   ARM: Kconfig: Introduce MACH_STM32F746 flag (2016-11-15 12:02:59 +0100)

----------------------------------------------------------------
STM32 SOC updates for v4.10, round 1.

Highlights:
----------
  - Add new MCU SOC STM32F746

----------------------------------------------------------------
Alexandre TORGUE (2):
       ARM: mach-stm32: Add a new SOC - STM32F746
       ARM: Kconfig: Introduce MACH_STM32F746 flag

  Documentation/arm/stm32/overview.txt           |  3 ++-
  Documentation/arm/stm32/stm32f746-overview.txt | 34 
++++++++++++++++++++++++++
  arch/arm/Kconfig                               |  5 ++++
  arch/arm/mach-stm32/board-dt.c                 |  1 +
  4 files changed, 42 insertions(+), 1 deletion(-)
  create mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
