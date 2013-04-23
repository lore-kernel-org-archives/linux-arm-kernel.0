From: vkale@apm.com (Vinayak Kale)
Date: Tue, 23 Apr 2013 15:55:55 +0530
Subject: [PATCH V2 0/4] arm64: Initial patch-set for APM X-Gene SOC family
Message-ID: <1366712759-3431-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are initial patches for APM X-Gene SOC family.
This patch-set is based on soc-armv8-model branch of git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git

Changelog:

-V2:
 * set NR_CPUS in arch/arm64/Kconfig based on selected targets
 * use default defconfig instead of xgene_defconfig
 * added 'apm-' prefix to dts filenames
 * fixed #address-cells in /cpus node in dts file
 * fixed cpu node naming under /cpus node in dts file
 * fixed serial device node name in dts file

-V1: Initial post

Vinayak Kale (4):
  arm64: Add Kconfig option for APM X-Gene SOC family
  arm64: Enable APM X-Gene SOC family in the defconfig
  arm64: Add defines for APM ARMv8 implementation
  arm64: Add initial DTS for APM X-Gene Storm SOC and APM Mustang board

 arch/arm64/Kconfig                  |    7 ++
 arch/arm64/boot/dts/Makefile        |    1 +
 arch/arm64/boot/dts/apm-mustang.dts |   27 ++++++++
 arch/arm64/boot/dts/apm-storm.dtsi  |  116 +++++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig        |    4 +
 arch/arm64/include/asm/cputype.h    |    3 +
 6 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apm-mustang.dts
 create mode 100644 arch/arm64/boot/dts/apm-storm.dtsi

-- 
1.7.4.1
