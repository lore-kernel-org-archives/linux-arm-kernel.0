From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 15:46:18 -0600
Subject: [PATCH] MAINTAINERS: Change QCOM entries
Message-ID: <1449870378-13232-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Gross <agross@codeaurora.org>

This patch changes the email address for Andy Gross and David Brown and drops
Kumar Gala.  In addition, it changes the location of the repository.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69c8a9c..32699df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1400,9 +1400,8 @@ W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
 ARM/QUALCOMM SUPPORT
-M:	Kumar Gala <galak@codeaurora.org>
-M:	Andy Gross <agross@codeaurora.org>
-M:	David Brown <davidb@codeaurora.org>
+M:	Andy Gross <andy.gross@linaro.org>
+M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm at vger.kernel.org
 L:	linux-soc at vger.kernel.org
 S:	Maintained
@@ -1413,7 +1412,7 @@ F:	drivers/tty/serial/msm_serial.c
 F:	drivers/*/pm8???-*
 F:	drivers/mfd/ssbi.c
 F:	drivers/firmware/qcom_scm.c
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
