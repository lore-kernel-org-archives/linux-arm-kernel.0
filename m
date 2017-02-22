From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:21 +0100
Subject: [PATCH v2 1/8] Documentation: arm: Marvell: Document IAP140
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IAP140 is either based on or was renamed from PXA1908.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new (Thomas)
 
 Documentation/arm/Marvell/README | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index b5bb7f5..e9d4873 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -243,7 +243,7 @@ PXA 2xx/3xx/93x/95x family
    Linux kernel plat directory: arch/arm/plat-pxa
 
 MMP/MMP2/MMP3 family (communication processor)
------------------------------------------
+----------------------------------------------
 
    Flavors:
         PXA168, a.k.a Armada 168
@@ -295,6 +295,16 @@ MMP/MMP2/MMP3 family (communication processor)
    Linux kernel mach directory: arch/arm/mach-mmp
    Linux kernel plat directory: arch/arm/plat-pxa
 
+MMP ARMv8 family (application processor)
+----------------------------------------
+
+  Flavors:
+        IAP140
+          Product brief: http://www.marvell.com/application-processors/assets/Marvell-IAP140-Platform-Brief-20160601.pdf
+          Core: quad-core ARMv8 Cortex-A53
+
+  Homepage: http://www.marvell.com/application-processors/
+
 Berlin family (Multimedia Solutions)
 -------------------------------------
 
-- 
2.10.2
