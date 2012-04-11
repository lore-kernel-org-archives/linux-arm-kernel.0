From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Apr 2012 13:54:42 +0200
Subject: [PATCH 1/5] MAINTAINERS: add entry for Atmel isi driver
In-Reply-To: <cover.1334137680.git.nicolas.ferre@atmel.com>
References: <cover.1334137680.git.nicolas.ferre@atmel.com>
Message-ID: <f686533aa5c706786b7e450549fa3720bf3701c1.1334137680.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2dcfca8..652dad7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,6 +1331,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL ISI DRIVER
+M:	Josh Wu <josh.wu@atmel.com>
+L:	linux-media at vger.kernel.org
+S:	Supported
+F:	drivers/media/video/atmel-isi.c
+F:	include/media/atmel-isi.h
+
 ATMEL LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	linux-fbdev at vger.kernel.org
-- 
1.7.9.4
