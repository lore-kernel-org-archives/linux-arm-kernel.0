From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 May 2016 17:06:36 +0100
Subject: [PATCH v4 02/18] ARM: multi_v7_defconfig: enable st xp70 rproc driver.
In-Reply-To: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1464192412-16386-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used by other device drivers whose IP is based
around the xp70 slim core (such as fdma) to load and
boot the firmware in the slimcore.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..d319d8f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -503,6 +503,7 @@ CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_VEXPRESS=y
+CONFIG_ST_XP70_REMOTEPROC=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
-- 
1.9.1
