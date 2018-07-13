From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 13 Jul 2018 16:01:40 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.19 #1
Message-ID: <016b1449-4ede-9302-e6f9-c52b63e0330e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 defconfig updates for v4.19.
This time it concerns only multi_v7_defconfig.

Thanks.
Alex

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.19-1

for you to fetch changes up to 1b8a8589a3e10997fa8f43e7da874c4903f33ac7:

   ARM: multi_v7_defconfig: enable STM32 DCMI media support (2018-07-13 
14:54:24 +0200)

----------------------------------------------------------------
STM32 defconfig updates for v4.19, round 1

Highlights:
----------

In multi_v7_defconfig, add support of:

-STM32 RTC
-STM32 DMA, DMAMUX and MDMA
-STM32 DCMI media

----------------------------------------------------------------
Amelie Delaunay (1):
       ARM: multi_v7_defconfig: enable STM32 RTC

Hugues Fruchet (1):
       ARM: multi_v7_defconfig: enable STM32 DCMI media support

Pierre-Yves MORDRET (1):
       ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX and MDMA

  arch/arm/configs/multi_v7_defconfig | 5 +++++
  1 file changed, 5 insertions(+)
