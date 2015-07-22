From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 19:22:46 +0200
Subject: [GIT PULL] STi defconfig updates for v4.3, round 1
Message-ID: <55AFD166.2070703@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi defconfig updates for v4.3:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-defconfig-for-v4.3-1

for you to fetch changes up to 5ecd29ac5eaafbadaf80fc30c3b1a1ead8072294:

   ARM: multi_v7_defconfig: Enable support for PWM Regulators 
(2015-07-22 14:29:45 +0200)

----------------------------------------------------------------
STi defconfig for v4.3, round 1

Highlights:
-----------
  - Enable support ST's PWM driver in multi_v7
  - Enable support PWM regulator in multi_v7

----------------------------------------------------------------
Lee Jones (2):
       ARM: multi_v7_defconfig: Enable ST's PWM driver
       ARM: multi_v7_defconfig: Enable support for PWM Regulators

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
