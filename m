From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 8 Apr 2016 15:22:09 +0200
Subject: [GIT PULL] STi defconfig updates for v4.7 #1
Message-ID: <5707B081.9030508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi defconfig updates for v4.7:

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-defconfig-for-v4.7-1

for you to fetch changes up to 6d54fb8a08a7b9ac06bbf4d7c41e6818d22e392f:

   ARM: multi_v7_defconfig: Enable ST's HW Random Number Generator 
(2016-04-07 09:38:13 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Enable ST's HW Random number generator in multi_v7 defconfig
  - Enable PWM regulator support in multi_v7 defconfig
  - Enable ST's Power and Reset driver in multi_v7 defconfig
  - Enable ST's PWM in multi_v7 defconfig

----------------------------------------------------------------
Lee Jones (4):
       ARM: multi_v7_defconfig: Enable ST's PWM driver
       ARM: multi_v7_defconfig: Enable ST's Power Reset driver
       ARM: multi_v7_defconfig: Enable support for PWM Regulators
       ARM: multi_v7_defconfig: Enable ST's HW Random Number Generator

  arch/arm/configs/multi_v7_defconfig | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-
