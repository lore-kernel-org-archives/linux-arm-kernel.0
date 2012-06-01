From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  1 Jun 2012 00:26:13 -0300
Subject: [PATCH] ARM: mxs: Enable MACH_APX4DEVKIT
Message-ID: <1338521173-32357-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Enable MACH_APX4DEVKIT to be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 5406c23..ce97c33 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_MX28EVK=y
 CONFIG_MACH_STMP378X_DEVB=y
 CONFIG_MACH_TX28=y
 CONFIG_MACH_M28EVK=y
+CONFIG_MACH_APX4DEVKIT=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
1.7.1
