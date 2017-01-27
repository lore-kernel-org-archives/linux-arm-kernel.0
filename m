From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 27 Jan 2017 18:21:57 +0100
Subject: [GIT PULL] STM32 defconfig changes for v4.11 #1
Message-ID: <a31ac10a-474b-72de-0e28-a3ceaa0c709b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 defconfig updates for v4.11:

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.11-1

for you to fetch changes up to 770e96f30cc2e4a363dd8fae2e9028173b1f2af1:

   ARM: configs: stm32: Add RTC support in STM32 defconfig (2017-01-16 
14:39:49 +0100)

----------------------------------------------------------------
STM32 defconfig updates for v4.11, round 1.

Highlights:
----------
  - Enable ADC
  - Enable RTC

----------------------------------------------------------------
Amelie Delaunay (1):
       ARM: configs: stm32: Add RTC support in STM32 defconfig

Fabrice GASNIER (1):
       ARM: configs: stm32: enable ADC driver

  arch/arm/configs/stm32_defconfig | 7 +++++++
  1 file changed, 7 insertions(+)
