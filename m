From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jun 2013 18:56:18 +0200
Subject: [PATCHv3 10/11] arm: mvebu: indicate that this platform supports MSI
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1371660979-21588-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the pieces are in place, we can adjust the
mach-mvebu/Kconfig file to indicate that this platform supports MSIs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 9eb63d7..36951b1 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -15,6 +15,7 @@ config ARCH_MVEBU
 	select ARCH_REQUIRE_GPIOLIB
 	select MIGHT_HAVE_PCI
 	select PCI_QUIRKS if PCI
+	select ARCH_SUPPORTS_MSI if PCI
 
 if ARCH_MVEBU
 
-- 
1.8.1.2
