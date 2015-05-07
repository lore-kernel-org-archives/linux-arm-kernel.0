From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 7 May 2015 14:44:06 +0200
Subject: [GIT PULL] STi defconfig changes for v4.2
Message-ID: <554B5E16.4060502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi defconfig updates for v4.2:

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-defconfig-for-v4.2-1

for you to fetch changes up to cb6a7a9e00fda1d51880ac0e93ad54a87034e822:

   ARM: multi_v7_defconfig: Enable support for ST's LPC RTC (2015-04-30 
13:16:05 +0200)

----------------------------------------------------------------
STi defconfig for v4.2, round 1.

Highlights:
-----------
  - Enable ST's LPC Watchdog driver
  - Enable ST's LPC RTC driver

----------------------------------------------------------------
Lee Jones (2):
       ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
       ARM: multi_v7_defconfig: Enable support for ST's LPC RTC

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
