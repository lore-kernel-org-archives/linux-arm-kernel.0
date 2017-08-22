From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 21 Aug 2017 20:35:02 -0700
Subject: [PATCH v1 3/3] MAINTAINERS: Add entry for the Nuvoton NPCM
 architecture
In-Reply-To: <20170822033502.4100-1-brendanhiggins@google.com>
References: <20170822033502.4100-1-brendanhiggins@google.com>
Message-ID: <20170822033502.4100-4-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainers and reviewers for the Nuvoton NPCM architecture.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44cb004c765d..67064bf11904 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,6 +1598,19 @@ F:	drivers/pinctrl/nomadik/
 F:	drivers/i2c/busses/i2c-nomadik.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
+ARM/NUVOTON NPCM ARCHITECTURE
+M:	Avi Fishman <avifishman70@gmail.com>
+M:	Tomer Maimon <tmaimon77@gmail.com>
+R:	Brendan Higgins <brendanhiggins@google.com>
+R:	Rick Altherr <raltherr@google.com>
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
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
2.14.1.480.gb18f417b89-goog
