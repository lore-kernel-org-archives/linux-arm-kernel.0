From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Mon, 24 Sep 2018 17:09:04 -0500
Subject: [PATCH 2/4] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
In-Reply-To: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1537826946-18942-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add System Manager driver by default for SOCFPGA ARM32 platforms.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..c510a32f9f0d 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -109,6 +109,7 @@ CONFIG_SENSORS_LTC2978_REGULATOR=y
 CONFIG_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_MFD_ALTERA_A10SR=y
+CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.7.4
