From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:57 +0400
Subject: [PATCH 6/9] ARM: sa1100: enable IRQ domains
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e6521927..a00b3c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -718,6 +718,7 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select IRQ_DOMAIN
 	select ISA
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
-- 
1.8.4.2
