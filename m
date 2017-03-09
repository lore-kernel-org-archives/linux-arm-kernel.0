From: ho.jia.jie@intel.com (ho.jia.jie at intel.com)
Date: Thu,  9 Mar 2017 08:43:41 +0800
Subject: [PATCH] ARM: socfpga: updates for socfpga_defconfig
Message-ID: <1489020221-22630-1-git-send-email-ho.jia.jie@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jia Jie Ho <ho.jia.jie@intel.com>

This patch enables Altera TSE support for
Arria10 SoC FPGA

Signed-off-by: Jia Jie Ho <ho.jia.jie@intel.com>
---
 arch/arm/configs/socfpga_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 030264c..df50380 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -71,6 +71,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_ALTERA_TSE=y
 CONFIG_E1000E=m
 CONFIG_IGB=m
 CONFIG_IXGBE=m
-- 
1.7.7.4
