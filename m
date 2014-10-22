From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 21 Oct 2014 19:09:51 -0700
Subject: [PATCH v6 5/6] MAINTAINERS: Entry for Cygnus/iproc arm architecture
In-Reply-To: <1413943792-7379-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1413943792-7379-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1413943792-7379-6-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jonathan Richardson <jonathar@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 MAINTAINERS |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0f17d5..dfe255f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2125,6 +2125,20 @@ L:	linux-scsi at vger.kernel.org
 S:	Supported
 F:	drivers/scsi/bnx2i/
 
+BROADCOM CYGNUS/IPROC ARM ARCHITECTURE
+M:	Ray Jui <rjui@broadcom.com>
+M:	Scott Branden <sbranden@broadcom.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	bcm-kernel-feedback-list at broadcom.com
+T:	git git://git.github.com/brcm/linux.git
+S:	Maintained
+N:	iproc
+N:	cygnus
+N:	bcm9113*
+N:	bcm9583*
+N:	bcm583*
+N:	bcm113*
+
 BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
 L:	bcm-kernel-feedback-list at broadcom.com
-- 
1.7.9.5
