From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 20 Feb 2016 19:49:24 +0530
Subject: [PATCH v2 5/5] MAINTAINERS: Add entry for Broadcom Vulcan SoC
In-Reply-To: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
References: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455977964-8099-6-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer information for Broadcom's Vulcan arm64 SoC.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2f753..eac98eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2512,6 +2512,13 @@ L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bcmsysport.*
 
+BROADCOM VULCAN ARM64 SOC
+M:	Jayachandran C. <jchandra@broadcom.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	bcm-kernel-feedback-list at broadcom.com
+S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/vulcan*
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
1.9.1
