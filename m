From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 2 Feb 2011 17:38:22 -0700
Subject: [PATCH] ep93xx: fix build error in edb93xx framebuffer support
Message-ID: <201102021738.22717.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing semicolon to fix a build error.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Reported-by: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9b00bee..3f37567 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -126,7 +126,7 @@ static int __init edb93xx_has_fb(void)
 	/* These platforms have an ep93xx with video capability */
 	return (machine_is_edb9307() || machine_is_edb9307a() ||
 		machine_is_edb9312() || machine_is_edb9315() ||
-		machine_is_edb9315a())
+		machine_is_edb9315a());
 }
 
 static void __init edb93xx_register_fb(void)
