From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 24 Sep 2018 17:12:47 +0200
Subject: [PATCH 0/2] Add cpufreq support for Armada 8K
Message-ID: <20180924151249.32328-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the second version of a the series adding the cpufreq support
for the Marvell Armada 8K SoCs.

Gregory

Changelog:
v1 -> v2:

 - Fix typos in MAINTAINERS (reported by Baruch Siach) and in
   armada-8k-cpufreq.c (reported by Thomas Petazzoni)

 - Fix indentation in Kconfig.arm  (reported by Thomas Petazzoni)

 - Use const for opps_div  (reported by Thomas Petazzoni)

 - Fix memory leak of opps_array  (reported by Thomas Petazzoni)


Gregory CLEMENT (2):
  MAINTAINERS: add new entries for Armada 8K cpufreq driver
  cpufreq: ap806: add cpufreq driver for Armada 8K

 MAINTAINERS                         |   1 +
 drivers/cpufreq/Kconfig.arm         |  11 +++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 148 ++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

-- 
2.19.0
