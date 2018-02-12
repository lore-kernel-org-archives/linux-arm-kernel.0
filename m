From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 12 Feb 2018 12:58:33 -0800
Subject: [PATCH v1 2/2] MAINTAINERS: Add low-level debug files to Nuvoton NPCM
 section
In-Reply-To: <20180212205833.151019-1-brendanhiggins@google.com>
References: <20180212205833.151019-1-brendanhiggins@google.com>
Message-ID: <20180212205833.151019-3-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds low-level debug files for NPCM7XX architecture to the Nuvoton NPCM
architecture section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fa95aba0f7f..4eaa66bc0562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,6 +1608,7 @@ L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	arch/arm/include/debug/npcm7xx.S
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
 F:	drivers/*/*npcm*
 F:	Documentation/*/*npcm*
-- 
2.16.0.rc1.238.g530d649a79-goog
