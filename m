From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 21:55:03 -0800
Subject: [PATCH] MAINTAINERS: Add rules for Qualcomm dts files
Message-ID: <1448344503-32403-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the get_maintainer script pick up the proper maintainers for the
Qualcomm dts files.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcf40fdc8178..a11764c15b62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1406,6 +1406,8 @@ M:	David Brown <davidb@codeaurora.org>
 L:	linux-arm-msm at vger.kernel.org
 L:	linux-soc at vger.kernel.org
 S:	Maintained
+F:	arch/arm/boot/dts/qcom-*.dts
+F:	arch/arm/boot/dts/qcom-*.dtsi
 F:	arch/arm/mach-qcom/
 F:	drivers/soc/qcom/
 F:	drivers/tty/serial/msm_serial.h
-- 
2.4.2
