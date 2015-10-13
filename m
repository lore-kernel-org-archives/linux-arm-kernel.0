From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Tue, 13 Oct 2015 13:30:02 -0500
Subject: [PATCH] ARM: socfpga_defconfig: enable fpga manager
Message-ID: <1444761002-1423-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Enable fpga manager framework and low level driver for
socfpga in socfpga_defconfig

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index a2956c3..8128b93e 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -86,6 +86,8 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_DWC2_HOST=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
+CONFIG_FPGA=y
+CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.9.1
