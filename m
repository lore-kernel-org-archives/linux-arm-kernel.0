From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 06:59:05 +0200
Subject: [PATCH v2 3/5] ARM: vexpress_defconfig: Cleanup from non-existing
 options
In-Reply-To: <1500353947-26122-1-git-send-email-krzk@kernel.org>
References: <1500353947-26122-1-git-send-email-krzk@kernel.org>
Message-ID: <1500353947-26122-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_VEXPRESS_CA9X4 is gone since commit 81cc3f868d30 ("ARM: vexpress:
Remove non-DT code").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm/configs/vexpress_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 0fa0ed577b15..edae1c58fe80 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -19,7 +19,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_VEXPRESS=y
-CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_VEXPRESS_DCSCB=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
 # CONFIG_SWP_EMULATE is not set
-- 
2.7.4
