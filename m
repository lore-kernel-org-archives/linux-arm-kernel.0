From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 20 Jun 2016 17:07:35 -0400
Subject: [PATCH 2/4] MAINTAINERS: Add NS2 entry
In-Reply-To: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
References: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1466456857-11969-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NS2 to the Broadcom iProc Subsystem maintainers entry.  Since most
of the NS2 entries are already covered via the ns* already present
there, all that is currently needed is to reference the device tree
files.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 18b235a..81be402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2612,6 +2612,7 @@ N:	bcm583*
 N:	bcm585*
 N:	bcm586*
 N:	bcm88312
+F:	arch/arm64/boot/dts/broadcom/ns2*
 F:	drivers/clk/bcm/clk-ns*
 F:	drivers/pinctrl/bcm/pinctrl-ns*
 
-- 
1.9.1
