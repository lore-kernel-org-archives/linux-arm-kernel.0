From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Oct 2014 16:36:03 +0100
Subject: [PATCH 1/4] pinctrl: sunxi: Add PN bank base pin
In-Reply-To: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414337766-23690-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 R-PIO controller has one more bank that what we've seen so far, add the
PN pin bank.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 4245b96c7996..5a51523a3459 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -27,6 +27,7 @@
 #define PI_BASE	256
 #define PL_BASE	352
 #define PM_BASE	384
+#define PN_BASE	416
 
 #define SUNXI_PINCTRL_PIN(bank, pin)		\
 	PINCTRL_PIN(P ## bank ## _BASE + (pin), "P" #bank #pin)
-- 
2.1.1
