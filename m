From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 22 Feb 2016 14:22:30 +0100
Subject: [PATCH] MAINTAINERS: alpine: add a new maintainer and update the entry
Message-ID: <1456147350-7236-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as a co-maintainer for the Alpine support. Also update the
entry to take in account Alpine ARM64 boards, Alpine ARM device trees
and Alpine-specific drivers.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..53c07990e0f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -938,8 +938,12 @@ N:	meson[x68]
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
+M:	Antoine Tenart <antoine.tenart@free-electrons.com>
 S:	Maintained
 F:	arch/arm/mach-alpine/
+F:	arch/arm/boot/dts/alpine*
+F:	arch/arm64/boot/dts/al/
+F:	drivers/*/*alpine*
 
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-- 
2.7.1
