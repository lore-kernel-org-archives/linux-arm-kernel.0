From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 16 Apr 2014 10:19:44 +0800
Subject: [RFC][PATCH 0/3] Add Freescale FlexTimer Module timer.
Message-ID: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Xiubo Li (3):
  ARM: dts: vf610: Add Freescale FlexTimer Module timer node.
  ARM: dts: vf610-twr: Enable Freescale FlexTimer Module timer.
  clocksource: Add Freescale FlexTimer Module (FTM) timer support

 arch/arm/boot/dts/vf610-twr.dts     |   4 +
 arch/arm/boot/dts/vf610.dtsi        |  13 ++
 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/fsl_ftm_timer.c | 238 ++++++++++++++++++++++++++++++++++++
 5 files changed, 261 insertions(+)
 create mode 100644 drivers/clocksource/fsl_ftm_timer.c

-- 
1.8.4
