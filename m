From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 14 May 2015 18:03:19 +0200
Subject: [GIT PULL] STi defconfig changes for v4.2, round 2
Message-ID: <5554C747.6070604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STi defconfig updates for v4.2

The following changes since commit cb6a7a9e00fda1d51880ac0e93ad54a87034e822:

   ARM: multi_v7_defconfig: Enable support for ST's LPC RTC (2015-04-30 
13:16:05 +0200)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-defconfig-for-v4.2-2

for you to fetch changes up to 80b41ae78353ecd2a7e3988333ca3332fe59f1b1:

   ARM: multi_v7_defconfig: Enable ST's Power Reset driver (2015-05-13 
11:18:22 +0200)

----------------------------------------------------------------
STi defconfig for v4.2, round 2.

Highlights:
-----------
  - Enable STi PWM driver in multi_v7_defconfig
  - Enable STi Power & Reset driver in multi_v7_defconfig

----------------------------------------------------------------
Lee Jones (2):
       ARM: multi_v7_defconfig: Enable ST's PWM driver
       ARM: multi_v7_defconfig: Enable ST's Power Reset driver

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
