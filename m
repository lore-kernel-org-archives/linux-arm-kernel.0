From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:13 +0200
Subject: [PATCH 10/15] pinctrl: sunxi: add PL pin definitions
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define PL pin macros.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index 552b0e9..ef8890d 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -25,6 +25,7 @@
 #define PG_BASE	192
 #define PH_BASE	224
 #define PI_BASE	256
+#define PL_BASE	352
 
 #define SUNXI_PINCTRL_PIN_PA0	PINCTRL_PIN(PA_BASE + 0, "PA0")
 #define SUNXI_PINCTRL_PIN_PA1	PINCTRL_PIN(PA_BASE + 1, "PA1")
@@ -323,6 +324,39 @@
 #define SUNXI_PINCTRL_PIN_PI30	PINCTRL_PIN(PI_BASE + 30, "PI30")
 #define SUNXI_PINCTRL_PIN_PI31	PINCTRL_PIN(PI_BASE + 31, "PI31")
 
+#define SUNXI_PINCTRL_PIN_PL0	PINCTRL_PIN(PL_BASE + 0, "PL0")
+#define SUNXI_PINCTRL_PIN_PL1	PINCTRL_PIN(PL_BASE + 1, "PL1")
+#define SUNXI_PINCTRL_PIN_PL2	PINCTRL_PIN(PL_BASE + 2, "PL2")
+#define SUNXI_PINCTRL_PIN_PL3	PINCTRL_PIN(PL_BASE + 3, "PL3")
+#define SUNXI_PINCTRL_PIN_PL4	PINCTRL_PIN(PL_BASE + 4, "PL4")
+#define SUNXI_PINCTRL_PIN_PL5	PINCTRL_PIN(PL_BASE + 5, "PL5")
+#define SUNXI_PINCTRL_PIN_PL6	PINCTRL_PIN(PL_BASE + 6, "PL6")
+#define SUNXI_PINCTRL_PIN_PL7	PINCTRL_PIN(PL_BASE + 7, "PL7")
+#define SUNXI_PINCTRL_PIN_PL8	PINCTRL_PIN(PL_BASE + 8, "PL8")
+#define SUNXI_PINCTRL_PIN_PL9	PINCTRL_PIN(PL_BASE + 9, "PL9")
+#define SUNXI_PINCTRL_PIN_PL10	PINCTRL_PIN(PL_BASE + 10, "PL10")
+#define SUNXI_PINCTRL_PIN_PL11	PINCTRL_PIN(PL_BASE + 11, "PL11")
+#define SUNXI_PINCTRL_PIN_PL12	PINCTRL_PIN(PL_BASE + 12, "PL12")
+#define SUNXI_PINCTRL_PIN_PL13	PINCTRL_PIN(PL_BASE + 13, "PL13")
+#define SUNXI_PINCTRL_PIN_PL14	PINCTRL_PIN(PL_BASE + 14, "PL14")
+#define SUNXI_PINCTRL_PIN_PL15	PINCTRL_PIN(PL_BASE + 15, "PL15")
+#define SUNXI_PINCTRL_PIN_PL16	PINCTRL_PIN(PL_BASE + 16, "PL16")
+#define SUNXI_PINCTRL_PIN_PL17	PINCTRL_PIN(PL_BASE + 17, "PL17")
+#define SUNXI_PINCTRL_PIN_PL18	PINCTRL_PIN(PL_BASE + 18, "PL18")
+#define SUNXI_PINCTRL_PIN_PL19	PINCTRL_PIN(PL_BASE + 19, "PL19")
+#define SUNXI_PINCTRL_PIN_PL20	PINCTRL_PIN(PL_BASE + 20, "PL20")
+#define SUNXI_PINCTRL_PIN_PL21	PINCTRL_PIN(PL_BASE + 21, "PL21")
+#define SUNXI_PINCTRL_PIN_PL22	PINCTRL_PIN(PL_BASE + 22, "PL22")
+#define SUNXI_PINCTRL_PIN_PL23	PINCTRL_PIN(PL_BASE + 23, "PL23")
+#define SUNXI_PINCTRL_PIN_PL24	PINCTRL_PIN(PL_BASE + 24, "PL24")
+#define SUNXI_PINCTRL_PIN_PL25	PINCTRL_PIN(PL_BASE + 25, "PL25")
+#define SUNXI_PINCTRL_PIN_PL26	PINCTRL_PIN(PL_BASE + 26, "PL26")
+#define SUNXI_PINCTRL_PIN_PL27	PINCTRL_PIN(PL_BASE + 27, "PL27")
+#define SUNXI_PINCTRL_PIN_PL28	PINCTRL_PIN(PL_BASE + 28, "PL28")
+#define SUNXI_PINCTRL_PIN_PL29	PINCTRL_PIN(PL_BASE + 29, "PL29")
+#define SUNXI_PINCTRL_PIN_PL30	PINCTRL_PIN(PL_BASE + 30, "PL30")
+#define SUNXI_PINCTRL_PIN_PL31	PINCTRL_PIN(PL_BASE + 31, "PL31")
+
 #define SUNXI_PIN_NAME_MAX_LEN	5
 
 #define BANK_MEM_SIZE		0x24
-- 
1.8.3.2
