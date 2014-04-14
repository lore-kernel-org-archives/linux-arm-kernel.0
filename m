From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Apr 2014 13:03:38 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable option
 CONFIG_LOCALVERSION_AUTO
Message-ID: <1397451818-27372-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Option CONFIG_LOCALVERSION_AUTO is quite helpful to tell kernel version.
I do not see any reason why we should unset it.  Let's remove the unset
to have it enabled.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bf5ad0f..9fc3024 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
-- 
1.8.3.2
