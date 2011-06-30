From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:26:24 +0900
Subject: [PATCH 0/3] ARM: EXYNOS4: NURI Support NTC
Message-ID: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches require NTC thermistor support.
NTC thermistor support patch is submitted and told to be applied (lm-sensors) although it is not being found in -next branches just yet.
You can find the patch at:
http://comments.gmane.org/gmane.linux.drivers.sensors/26475

MyungJoo Ham (3):
  Samsung SoC: NTC Thermistor attached to S3C-ADC.
  Samsung SoC: ready to use NTC value inside kernel
  Exynos4 NURI: support for NTC thermistor

 arch/arm/mach-exynos4/mach-nuri.c            |    4 +
 arch/arm/plat-samsung/dev-adc.c              |  119 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/adc-ntc.h |   19 ++++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 4 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/adc-ntc.h

-- 
1.7.4.1
