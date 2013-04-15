From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Mon, 15 Apr 2013 13:44:52 +0900
Subject: [PATCH] arm: shmobile: armadillo800eva: Fix maximum number of SCIF
Message-ID: <1366001092-8753-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a77740 has 9ch SCIF. It is not 8ch.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 0f2d80d..fae939d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -86,7 +86,7 @@ CONFIG_TOUCHSCREEN_ST1232=y
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=8
+CONFIG_SERIAL_SH_SCI_NR_UARTS=9
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-- 
1.7.10.4
