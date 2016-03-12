From: andy.yan@kernel-upstream.org (Andy Yan)
Date: Sat, 12 Mar 2016 20:51:40 +0800
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable CONFIG_REGULATOR_PWM=y
In-Reply-To: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
References: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
Message-ID: <1457787100-9221-1-git-send-email-andy.yan@kernel-upstream.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platform like Rockchip rk3066 use pwm as a regulator to modulate
cpu voltage, so pwm regulator should be enabled at system boot time if
the system want to run with high frequency.

Signed-off-by: Andy Yan <andy.yan@kernel-upstream.org>
---

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 94639b1..e0178f2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -477,7 +477,7 @@ CONFIG_REGULATOR_MAX77693=m
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
