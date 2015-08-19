From: b38611@freescale.com (Fugang Duan)
Date: Wed, 19 Aug 2015 13:33:59 +0800
Subject: [PATCH v1 1/6] net: phy: broadcom: add bcm54220 phy ID
In-Reply-To: <1439962444-27486-1-git-send-email-b38611@freescale.com>
References: <1439962444-27486-1-git-send-email-b38611@freescale.com>
Message-ID: <1439962444-27486-2-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bcm54220 phy ID entry.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 include/linux/brcmphy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 697ca77..20bed15 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -16,6 +16,7 @@
 #define PHY_ID_BCM5482			0x0143bcb0
 #define PHY_ID_BCM5411			0x00206070
 #define PHY_ID_BCM5421			0x002060e0
+#define PHY_ID_BCM54220			0x600d8589
 #define PHY_ID_BCM5464			0x002060b0
 #define PHY_ID_BCM5461			0x002060c0
 #define PHY_ID_BCM54616S		0x03625d10
-- 
1.9.1
