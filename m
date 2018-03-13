From: tmaimon77@gmail.com (Tomer Maimon)
Date: Tue, 13 Mar 2018 15:32:11 +0200
Subject: [PATCH v12 3/3] MAINTAINERS: Add entry for the Nuvoton NPCM
 architecture
In-Reply-To: <1520947931-15426-1-git-send-email-tmaimon77@gmail.com>
References: <1520947931-15426-1-git-send-email-tmaimon77@gmail.com>
Message-ID: <1520947931-15426-4-git-send-email-tmaimon77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainers and reviewers for the Nuvoton NPCM architecture.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..71cccfd9e26f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1700,6 +1700,20 @@ F:	Documentation/devicetree/bindings/arm/ste-*
 F:	Documentation/devicetree/bindings/arm/ux500/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
+ARM/NUVOTON NPCM ARCHITECTURE
+M:	Avi Fishman <avifishman70@gmail.com>
+M:	Tomer Maimon <tmaimon77@gmail.com>
+R:	Patrick Venture <venture@google.com>
+R:	Nancy Yuen <yuenn@google.com>
+R:	Brendan Higgins <brendanhiggins@google.com>
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-npcm/
+F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
+F:	drivers/*/*npcm*
+F:	Documentation/*/*npcm*
+
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
 M:	Wan ZongShun <mcuos.com@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.14.1
