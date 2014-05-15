From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 15 May 2014 12:01:28 -0400
Subject: [PATCH v1 1/5] ARM: keystone: add pcie related options
In-Reply-To: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1400169692-9677-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pcie related options by default for keystone architecture

CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/mach-keystone/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index f50bc93..f87844d 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -8,6 +8,8 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
+	select MIGHT_HAVE_PCI
+	select ARCH_SUPPORTS_MSI
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
