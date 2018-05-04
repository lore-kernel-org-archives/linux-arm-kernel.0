From: opensource.ganesh@gmail.com (Ganesh Mahendran)
Date: Fri,  4 May 2018 14:57:48 +0800
Subject: [PATCH v2 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Message-ID: <1525417069-27401-1-git-send-email-opensource.ganesh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
enables Speculative Page Fault handler.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
v2: remove "if SMP"
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..b3ca29d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
1.9.1
