From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 14:41:46 +0300
Subject: [PATCH 4/4] MAINTAINERS: digicolor: add dts files
In-Reply-To: <cover.1436182214.git.baruch@tkos.co.il>
References: <cover.1436182214.git.baruch@tkos.co.il>
Message-ID: <d28ee8b987e62ae4dd0332700f4a792ee8287065.1436182214.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'digicolor' regexp doesn't cover the dts files. Add a glob pattern for
them.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cefb6b6e..3961bc4b0ba6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1001,6 +1001,7 @@ ARM/CONEXANT DIGICOLOR MACHINE SUPPORT
 M:	Baruch Siach <baruch@tkos.co.il>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/dts/cx92755*
 N:	digicolor
 
 ARM/EBSA110 MACHINE SUPPORT
-- 
2.1.4
