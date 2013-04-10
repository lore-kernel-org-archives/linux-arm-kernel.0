From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 10 Apr 2013 12:07:22 +0800
Subject: [PATCH] ARM: pxa: select PXA935 on saar & tavorevb
Message-ID: <1365566842-16407-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since both PXA930 and PXA935 are used in Saar & TavorEVB platform,
select PXA935 too.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 0e74ba0..96100db 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -51,11 +51,13 @@ config MACH_LITTLETON
 config MACH_TAVOREVB
 	bool "PXA930 Evaluation Board (aka TavorEVB)"
 	select CPU_PXA930
+	select CPU_PXA935
 	select PXA3xx
 
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select CPU_PXA930
+	select CPU_PXA935
 	select PXA3xx
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
-- 
1.7.10.4
