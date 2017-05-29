From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Mon, 29 May 2017 17:17:54 +0200
Subject: [PATCH 1/1] MAINTAINERS: remove kernel@stlinux.com obsolete mailing
 list
Message-ID: <1496071074-29552-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

The STMicroelectronics dedicated mailing list kernel at stlinux.com
is no more available, remove it to avoid bouncing mails.

Several request to create a new mailing list has been send by Benjamin
Gaignard and me but without any answers.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 053c3bd..3faa966a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1829,7 +1829,6 @@ F:	drivers/edac/altera_edac.
 ARM/STI ARCHITECTURE
 M:	Patrice Chotard <patrice.chotard@st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	kernel at stlinux.com
 W:	http://www.stlinux.com
 S:	Maintained
 F:	arch/arm/mach-sti/
@@ -11268,7 +11267,6 @@ F:	drivers/media/rc/serial_ir.c
 
 STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
-L:	kernel at stlinux.com
 S:	Maintained
 F:	drivers/staging/media/st-cec/
 F:	Documentation/devicetree/bindings/media/stih-cec.txt
-- 
1.9.1
