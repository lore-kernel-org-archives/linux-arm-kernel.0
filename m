From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jun 2015 16:43:55 +0100
Subject: [PATCH 6/8] ARM: multi_v7_defconfig: Enable support for PWM Regulators
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1434987837-24212-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f632af0..6666973 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
-- 
1.9.1
