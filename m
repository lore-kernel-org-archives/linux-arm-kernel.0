From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:27 -0400
Subject: [PATCH 42/52] ARM: mach-shark: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-42-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-shark/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 1173082..042d5d8 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -154,7 +154,7 @@ static struct sys_timer shark_timer = {
 
 MACHINE_START(SHARK, "Shark")
 	/* Maintainer: Alexander Schulz */
-	.boot_params	= 0x08003000,
+	.atag_offset	= 0x3000,
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
 	.timer		= &shark_timer,
-- 
1.7.4
