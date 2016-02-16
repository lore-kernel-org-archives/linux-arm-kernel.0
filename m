From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Feb 2016 14:17:01 +0000
Subject: [PATCH 3/3] ARM: stm32: Identify a new board - STM32F469
In-Reply-To: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
References: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1455632221-31834-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index f2ad772..ceee477 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -10,6 +10,7 @@
 
 static const char *const stm32_compat[] __initconst = {
 	"st,stm32f429",
+	"st,stm32f469",
 	NULL
 };
 
-- 
1.9.1
