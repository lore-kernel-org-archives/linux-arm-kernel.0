From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Aug 2014 19:33:44 +0800
Subject: [PATCH v5 7/7] ARM: hi3xxx_defconfig: Enable HI6421 MFD and Regulators
In-Reply-To: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
References: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1407929624-8737-8-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HiSilicon Hi6421 MFD and regulator drivers in hi3xxx_defconfig

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm/configs/hi3xxx_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/hi3xxx_defconfig b/arch/arm/configs/hi3xxx_defconfig
index f186bdf..6cf9187 100644
--- a/arch/arm/configs/hi3xxx_defconfig
+++ b/arch/arm/configs/hi3xxx_defconfig
@@ -54,3 +54,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKUP_DETECTOR=y
+CONFIG_MFD_HI6421_PMIC=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_HI6421=y
-- 
1.9.1
