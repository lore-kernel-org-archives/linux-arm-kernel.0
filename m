From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 11:45:12 +0900
Subject: [PATCH 0/4] ARM: S5PV310: Add support S5PV310/S5PC210 CPUFREQ
Message-ID: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support CPUFREQ driver for S5PV310 and S5PC210.

NOTE: This patch dependes on following.
- ARM: S5PV310: Fix clkset_moutcore_list
- ARM: S5PV210: Add DMC map_desc table for supporting DMC access

[PATCH 1/4] ARM: S5PV310: Update CMU registers for CPUFREQ
[PATCH 2/4] ARM: S5PV310: Add DMC registers and map_desc
[PATCH 3/4] ARM: S5PV310: Add support CPUFREQ
[PATCH 4/4] ARM: S5PV310: Update Kconfig and Makefile for supporting CPUFREQ
