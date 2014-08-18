From: agross@codeaurora.org (Andy Gross)
Date: Mon, 18 Aug 2014 13:38:51 -0500
Subject: [PATCH] MAINTAINERS: Add entry for SOC Qualcomm drivers
Message-ID: <1408387131-32152-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for the SOC Qualcomm drivers.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..3ad0a26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8426,6 +8426,14 @@ F:	include/media/soc*
 F:	drivers/media/i2c/soc_camera/
 F:	drivers/media/platform/soc_camera/
 
+SOC/QUALCOMM DRIVERS
+M:	Andy Gross <agross@codeaurora.org>
+L:	linux-arm-msm at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/qcom
+T:	git git://codeaurora.org/quic/kernel/agross-msm.git
+
 SOEKRIS NET48XX LED SUPPORT
 M:	Chris Boot <bootc@bootc.net>
 S:	Maintained
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
