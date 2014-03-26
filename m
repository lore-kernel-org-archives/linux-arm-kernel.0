From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 26 Mar 2014 11:29:31 +0900
Subject: [PATCH 1/2] ARM: tegra: enable fhandle in tegra_defconfig
Message-ID: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is required by systemd >= 210 to spawn a serial TTY.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 131b8d6ff9d3..2926281368ab 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -1,4 +1,5 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
-- 
1.9.1
