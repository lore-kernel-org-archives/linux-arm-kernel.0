From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 27 Aug 2014 13:02:20 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable Control Groups support
Message-ID: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

systemd needs control groups support to be enabled in the
kernel so let's enable it by default since is quite likely
that a user-space with systemd will be used.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 676c744..590abde 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -1,6 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
-- 
2.0.1
