From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 16 Sep 2015 17:36:59 +0200
Subject: [PATCH v2 3/7] MAINTAINERS: Add an entry for pinctrl-at91-pio4
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442417823-15850-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the Atmel PIO4 controller driver.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 169ad39..ec41bfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8166,6 +8166,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pinctrl/pinctrl-at91.*
 
+PIN CONTROLLER - ATMEL AT91 PIO4
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-gpio at vger.kernel.org
+S:	Supported
+F:	drivers/pinctrl/pinctrl-at91-pio4.*
+
 PIN CONTROLLER - INTEL
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-- 
2.5.0
