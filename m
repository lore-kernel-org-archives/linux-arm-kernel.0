From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 8 Apr 2016 15:23:02 +0200
Subject: [GIT PULL] STi SoC updates for v4.7 #1
Message-ID: <5707B0B6.1030209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi SoC updates for v4.7:

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-soc-for-v4.7-1

for you to fetch changes up to 33406c805730377ff48741f9ad99e7aada91595b:

   ARM: STi: Update platform level menuconfig 'help' (2016-04-07 
16:32:14 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Add CPUFreq and RProc drivers to STI maintainers file list
  - Improve STi's menuconfig help entry

----------------------------------------------------------------
Lee Jones (3):
       MAINTAINERS: Add ST's CPUFreq driver to the STI file list
       MAINTAINERS: Add ST's Remote Processor Driver to ARM/STI ARCHITECTURE
       ARM: STi: Update platform level menuconfig 'help'

  MAINTAINERS               | 2 ++
  arch/arm/mach-sti/Kconfig | 9 ++++-----
  2 files changed, 6 insertions(+), 5 deletions(-)
