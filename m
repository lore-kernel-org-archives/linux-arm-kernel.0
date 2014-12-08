From: rjui@broadcom.com (Ray Jui)
Date: Mon, 8 Dec 2014 10:47:48 -0800
Subject: [PATCH v3 5/5] MAINTAINERS: Entry for Cygnus GPIO driver
In-Reply-To: <1418064468-8512-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418064468-8512-1-git-send-email-rjui@broadcom.com>
Message-ID: <1418064468-8512-7-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6bff3a..8473422 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2202,6 +2202,13 @@ N:	bcm9583*
 N:	bcm583*
 N:	bcm113*
 
+BROADCOM CYGNUS GPIO DRIVER
+M:	Ray Jui <rjui@broadcom.com>
+L:	bcm-kernel-feedback-list at broadcom.com
+S:	Supported
+F:	drivers/gpio/gpio-bcm-cygnus.c
+F:	Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt
+
 BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
 L:	bcm-kernel-feedback-list at broadcom.com
-- 
1.7.9.5
