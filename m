From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon, 8 Apr 2013 13:55:15 +1000
Subject: [PATCH] Remove trailing whitespace in arch/arm/Makefile
Message-ID: <979FD146-5650-409C-B18E-F1CDBBE67236@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ee4605f..479b209 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -313,7 +313,7 @@ define archhelp
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '* xipImage      - XIP kernel image, if configured (arch/$(ARCH)/boot/xipImage)'
   echo  '  uImage        - U-Boot wrapped zImage'
-  echo  '  bootpImage    - Combined zImage and initial RAM disk' 
+  echo  '  bootpImage    - Combined zImage and initial RAM disk'
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
   echo  '* dtbs          - Build device tree blobs for enabled boards'
   echo  '  install       - Install uncompressed kernel'
-- 
1.8.1.3
