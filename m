From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 28 Nov 2014 13:06:54 +0100
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_FHANDLE
Message-ID: <1417176414-21558-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is required by systemd, which is the default init system
in more and more distributions. So lets enable it for Exynos as well
(it's already enabled in multi_v7_defconfig)

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e419fac..d4751ef 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -1,4 +1,5 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
-- 
2.1.3
