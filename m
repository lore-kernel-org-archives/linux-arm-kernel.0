From: acolin@isi.edu (Alexei Colin)
Date: Tue, 31 Jul 2018 10:29:50 -0400
Subject: [RESEND PATCH 2/6] x86: factor out RapidIO Kconfig menu
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Message-ID: <20180731142954.30345-3-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The menu entry is now defined in the rapidio subtree.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86 at kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-mips at linux-mips.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/x86/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27fce7e84357..6f057000e486 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2828,14 +2828,6 @@ config AMD_NB
 
 source "drivers/pcmcia/Kconfig"
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	default n
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
 source "drivers/rapidio/Kconfig"
 
 config X86_SYSFB
-- 
2.18.0
