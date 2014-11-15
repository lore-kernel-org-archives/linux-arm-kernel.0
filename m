From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 14:53:49 +0300
Subject: [PATCH 3/6] ARM: sa1100: enable IRQ domains
In-Reply-To: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
References: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416052432-26192-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f3f132..622e364 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,7 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select IRQ_DOMAIN
 	select ISA
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
-- 
2.1.1
