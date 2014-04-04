From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:48:03 +0200
Subject: [PATCH 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-18-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle driver is broken since v3.11 and now we are at v3.14.

Default the cpuidle driver to favorize a better detection next time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/configs/exynos_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index dbe1f1c..7d8a689 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -132,3 +132,4 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRC_CCITT=y
+CONFIG_CPU_IDLE=y
-- 
1.7.9.5
