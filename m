From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 29 Oct 2014 12:45:32 -0400
Subject: [PATCH v1 2/4] ARM: keystone: defconfig: add options to enable PCI
 controller
In-Reply-To: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
References: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1414601134-31825-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 v1 - fixed email ID for Santosh
 arch/arm/configs/keystone_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 932ae40..40d3e9d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -20,6 +20,9 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARM_LPAE=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_KEYSTONE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.7.9.5
