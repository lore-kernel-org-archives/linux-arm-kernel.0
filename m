From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 May 2017 15:08:07 +0530
Subject: [PATCH] MAINTAINERS: add device-tree files to TI DaVinci entry
Message-ID: <20170525093807.21157-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree files relevant to TI DaVinci platform
to its entry so mach-davinci sub-arch maintainers get
copied on patches with device-tree file updates.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e984645c4b0..7a935d71f56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11778,6 +11778,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
 S:	Supported
 F:	arch/arm/mach-davinci/
 F:	drivers/i2c/busses/i2c-davinci.c
+F:	arch/arm/boot/dts/da850*
 
 TI DAVINCI SERIES MEDIA DRIVER
 M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
-- 
2.9.0
