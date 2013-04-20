From: vkale@apm.com (Vinayak Kale)
Date: Sat, 20 Apr 2013 12:45:27 +0530
Subject: [PATCH 0/4] arm64: Initial patch-set for APM X-Gene SOC family
Message-ID: <1366442131-26094-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are initial patches for APM X-Gene SOC family.
This patch-set is based on soc-armv8-model branch of git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git

Vinayak Kale (4):
  arm64: Add Kconfig option for APM X-Gene SOC family
  arm64: Initial defconfig for APM X-Gene SOC family
  arm64: Add defines for APM ARMv8 implementation
  arm64: Add initial DTS for APM X-Gene Storm SOC and APM Mustang board

 arch/arm64/Kconfig                 |    5 ++
 arch/arm64/boot/dts/Makefile       |    1 +
 arch/arm64/boot/dts/mustang.dts    |   28 +++++++++
 arch/arm64/boot/dts/storm.dtsi     |  116 ++++++++++++++++++++++++++++++++++++
 arch/arm64/configs/xgene_defconfig |   93 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h   |    3 +
 6 files changed, 246 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mustang.dts
 create mode 100644 arch/arm64/boot/dts/storm.dtsi
 create mode 100644 arch/arm64/configs/xgene_defconfig

-- 
1.7.4.1
