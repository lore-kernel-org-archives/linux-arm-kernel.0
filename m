From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jul 2015 16:06:47 +0100
Subject: [PATCH v2 3/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
In-Reply-To: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436281613-899-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4144fa4..4629bed 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -405,6 +405,7 @@ CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PWM=m
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
-- 
1.9.1
