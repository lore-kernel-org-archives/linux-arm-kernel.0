From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 08:57:14 +0000
Subject: [PATCH RESEND v4 5/5] MAINTAINERS: add maintainers for the NXP
 FlexSPI driver
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1540284888-32307-6-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc at lists.01.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
 
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi at vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.7.4
