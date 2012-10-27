From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 27 Oct 2012 19:53:12 +0200
Subject: [PATCH 2/2] MAINTAINERS: add pinctrl atmel at91 entry
In-Reply-To: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
References: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1351360392-8669-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-kernel at vger.kernel.org
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 027ec2b..cb97031 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5624,6 +5624,12 @@ S:	Maintained
 F:	drivers/pinctrl/
 F:	include/linux/pinctrl/
 
+PIN CONTROLLER - ATMEL AT91
+M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/pinctrl/pinctrl-at91.c
+
 PIN CONTROLLER - ST SPEAR
 M:	Viresh Kumar <viresh.linux@gmail.com>
 L:	spear-devel at list.st.com
-- 
1.7.10.4
