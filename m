From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 29 Nov 2017 16:49:53 +0800
Subject: [PATCH 2/2] usb: mtu3: remove unused micros
In-Reply-To: <120299c8a516acfd5b52cb1528b929b3eae5cd53.1511943941.git.chunfeng.yun@mediatek.com>
References: <120299c8a516acfd5b52cb1528b929b3eae5cd53.1511943941.git.chunfeng.yun@mediatek.com>
Message-ID: <a0a8a38a1ec24633d6c201449a04560c83948d62.1511943941.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused micros of UWK_CTL1_IDDIG_*

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_host.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index d237d7e..7e948c0 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -21,9 +21,6 @@
 #define PERI_WK_CTRL1		0x404
 #define UWK_CTL1_IS_C(x)	(((x) & 0xf) << 26)
 #define UWK_CTL1_IS_E		BIT(25)
-#define UWK_CTL1_IDDIG_C(x)	(((x) & 0xf) << 11)  /* cycle debounce */
-#define UWK_CTL1_IDDIG_E	BIT(10) /* enable debounce */
-#define UWK_CTL1_IDDIG_P	BIT(9)  /* polarity */
 #define UWK_CTL1_IS_P		BIT(6)  /* polarity for ip sleep */
 
 /*
-- 
1.9.1
