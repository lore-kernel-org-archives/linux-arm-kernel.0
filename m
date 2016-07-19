From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 19 Jul 2016 13:09:14 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable PM_DEBUG
Message-ID: <1468926554-22204-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM_DEBUG and PM_ADVANCED_DEBUG bring some information useful for
development and they should not cause any significant overhead.  Enable
them in default configuration so debugging would be slightly easier.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index a5aa44c56bfe..d7366891e9cf 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -35,6 +35,8 @@ CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
+CONFIG_PM_DEBUG=y
+CONFIG_PM_ADVANCED_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.9.1
