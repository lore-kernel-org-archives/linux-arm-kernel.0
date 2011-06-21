From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Jun 2011 11:07:09 +0900
Subject: [PATCH v2 0/4] ARM: Exynos4: NURI Board Configuration Udpate
In-Reply-To: <20110620103124.GD31864@opensource.wolfsonmicro.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
Message-ID: <1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1/4: Add configuration for MAX8997 PMIC and regulators
2/4: Add configuration for MAX17042 fuel gauge.
3/4: Add configuration for ADC
	depends on the recently submitted ADC for Samsung SoC patch series:
	[PATCH v2 0/5] Update Samsung-SoC ADC (regulator / recent CPU support)
4/4: Add configuration for NTC themistor.
	depends on the recently submitted NTC-thermistor patch:
	[PATCH v10] drivers/hwmon NTC Thermistor Initial Support v10 (applied to next)

MyungJoo Ham (4):
  Exynos4 NURI: configure regulators and PMIC
  Exynos4 NURI: configure MAX17042 fuel gauge
  Exynos4 NURI: configure ADC.
  Exynos4 NURI: support for NTC thermistor

 arch/arm/mach-exynos4/mach-nuri.c |  703 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 702 insertions(+), 1 deletions(-)

-- 
1.7.4.1
