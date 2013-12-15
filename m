From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:13 +0400
Subject: [PATCH v3 06/10] ARM: sa1100: enable IRQ domains
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 14e907e..4cf644a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -692,6 +692,7 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select IRQ_DOMAIN
 	select ISA
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
-- 
1.8.5.1
