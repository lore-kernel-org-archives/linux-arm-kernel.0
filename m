From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Dec 2015 15:58:10 +0000
Subject: [PATCH v6 03/10] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449676697-25432-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f62dcb1..648ef57 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -434,7 +434,7 @@ CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_MAX77802=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
-CONFIG_REGULATOR_PWM=m
+CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_S2MPS11=y
-- 
1.9.1
