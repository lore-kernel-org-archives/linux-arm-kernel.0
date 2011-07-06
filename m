From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:51 -0400
Subject: [PATCH 06/52] ARM: mach-ebsa110: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ebsa110/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index f8a94d6..e9fb3f2 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -284,7 +284,7 @@ arch_initcall(ebsa110_init);
 
 MACHINE_START(EBSA110, "EBSA110")
 	/* Maintainer: Russell King */
-	.boot_params	= 0x00000400,
+	.atag_offset	= 0x400,
 	.reserve_lp0	= 1,
 	.reserve_lp2	= 1,
 	.soft_reboot	= 1,
-- 
1.7.4
