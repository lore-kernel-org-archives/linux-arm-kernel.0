From: agross@codeaurora.org (Andy Gross)
Date: Wed, 21 Jan 2015 22:39:24 -0600
Subject: [PATCH] MAINTAINERS: update Qualcomm support entry
Message-ID: <1421901564-8854-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added myself as a co-maintainer.  Updated the files to include the Qualcomm SoC
directory.  Added linux-soc mailing list.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93409ad..2af6e23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1284,9 +1284,12 @@ S:	Maintained
 ARM/QUALCOMM SUPPORT
 M:	Kumar Gala <galak@codeaurora.org>
 M:	David Brown <davidb@codeaurora.org>
+M:	Andy Gross <agross@codeaurora.org>
 L:	linux-arm-msm at vger.kernel.org
+L:	linux-soc at vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-qcom/
+F:	drivers/soc/qcom
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
