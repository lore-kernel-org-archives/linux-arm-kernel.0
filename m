From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Jul 2016 15:44:27 +0200
Subject: [GIT PULL] ARM: at91: defconfig for 4.8 #2
Message-ID: <20160704134427.GA32636@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A late defconfig addition for the sama5d2 Xplained PMIC.

The following changes since commit 837f27a2c1b4093cda301aead20fcf7d04acc12a:

  ARM: multi_v5_defconfig: enable Atmel platforms (2016-06-11 00:58:51 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-defconfig2

for you to fetch changes up to 526b87fdba9160263c30ad6dfd79034ec0b21631:

  ARM: multi_v7_defconfig: add ACT8945A (2016-07-04 10:45:05 +0200)

----------------------------------------------------------------
Defconfig changes for 4.8 #2:
 - Addition of the sama5d2 xplained PMIC: ACT8945A

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: multi_v7_defconfig: add ACT8945A

Wenyou Yang (1):
      ARM: at91/defconfig: Add ACT8945A driver

 arch/arm/configs/multi_v7_defconfig | 3 +++
 arch/arm/configs/sama5_defconfig    | 3 +++
 2 files changed, 6 insertions(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
