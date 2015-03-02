From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon,  2 Mar 2015 18:20:32 +0000
Subject: [PATCH v2 5/5] ARM: virt: select ARM_GIC_V3
In-Reply-To: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <1425320432-6325-6-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows ARM guests to use GICv3 on an arm64 host

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..76246cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -834,6 +834,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V3
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
-- 
2.2.0.rc1
