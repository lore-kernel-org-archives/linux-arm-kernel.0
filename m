From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 16:45:03 +0200
Subject: [PATCH 6/6] MAINTAINERS: Add entry for the Amlogic MesonX SoCs
In-Reply-To: <1410792303-23275-1-git-send-email-carlo@caione.org>
References: <1410792303-23275-1-git-send-email-carlo@caione.org>
Message-ID: <1410792303-23275-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm going to maintain the platform.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 809ecd6..b1e1cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -835,6 +835,12 @@ M:	Emilio L?pez <emilio@elopez.com.ar>
 S:	Maintained
 F:	drivers/clk/sunxi/
 
+ARM/Amlogic MesonX SoC support
+M:	Carlo Caione <carlo@caione.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	meson[x68]
+
 ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
 M:	Andrew Victor <linux@maxim.org.za>
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-- 
1.9.1
