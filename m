From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu,  1 Oct 2015 13:47:18 +0100
Subject: [PATCH v3 5/6] ARM: virt: select ARM_GIC_V3
In-Reply-To: <1443703639-3730-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1443703639-3730-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <1443703639-3730-6-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows ARM guests to use GICv3 on an arm64 host

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..0d72535 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -819,6 +819,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V3
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
-- 
1.7.9.5
