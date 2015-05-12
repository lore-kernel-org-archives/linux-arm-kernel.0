From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 14:13:58 +0100
Subject: [PATCH] MAINTAINERS: Add Arnd Bergmann as Syscon reviewer
Message-ID: <1431436438-23434-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Configuration (syscon) driver is an important one, which
effects many ARM-SoC based platforms.  I'm adding Arnd as a primary
reviewer as he is highly competent in this area and has a keen
interest in ARM-SoC.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efbcb50..39fa313 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9468,6 +9468,13 @@ F:	arch/arc/
 F:	Documentation/devicetree/bindings/arc/
 F:	drivers/tty/serial/arc_uart.c
 
+SYSTEM CONFIGURATION (SYSCON)
+M:	Lee Jones <lee.jones@linaro.org>
+M:	Arnd Bergmann <arnd@arndb.de>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
+S:	Supported
+F:	drivers/mfd/syscon.c
+
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
-- 
1.9.1
