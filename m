From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon,  5 Feb 2018 15:57:57 -0800
Subject: [PATCH v9 3/3] MAINTAINERS: Add entry for the Nuvoton NPCM
 architecture
In-Reply-To: <20180205235757.246758-1-brendanhiggins@google.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
Message-ID: <20180205235757.246758-4-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainers and reviewers for the Nuvoton NPCM architecture.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44cb004c765d..2fa95aba0f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,6 +1598,20 @@ F:	drivers/pinctrl/nomadik/
 F:	drivers/i2c/busses/i2c-nomadik.c
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
2.16.0.rc1.238.g530d649a79-goog
