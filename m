From: ho.jia.jie@intel.com (ho.jia.jie at intel.com)
Date: Thu,  9 Mar 2017 13:49:36 +0800
Subject: [PATCH v2] ARM: socfpga: updates for socfpga_defconfig
Message-ID: <1489038576-32280-1-git-send-email-ho.jia.jie@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jia Jie Ho <ho.jia.jie@intel.com>

This patch enables Altera TSE support in socfpga_defconfig

Signed-off-by: Jia Jie Ho <ho.jia.jie@intel.com>
---
v2:
 * Adding the TSE support as a module for Arria10

 arch/arm/configs/socfpga_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 030264c..2620ce7 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -71,6 +71,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_ALTERA_TSE=m
 CONFIG_E1000E=m
 CONFIG_IGB=m
 CONFIG_IXGBE=m
-- 
1.7.7.4
