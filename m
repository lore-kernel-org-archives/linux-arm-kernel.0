From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 28 May 2015 21:57:53 +0900
Subject: [PATCH] pinctrl: zynq: add static const to zynq_pctrl_groups
Message-ID: <1432817873-6106-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This array is only referenced in this file and never updated.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index a687f24..93d3774 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -369,7 +369,7 @@ static const unsigned int usb1_0_pins[] = {40, 41, 42, 43, 44, 45, 46, 47, 48,
 		.npins = ARRAY_SIZE(nm ## _pins), \
 	}
 
-struct zynq_pctrl_group zynq_pctrl_groups[] = {
+static const struct zynq_pctrl_group zynq_pctrl_groups[] = {
 	DEFINE_ZYNQ_PINCTRL_GRP(ethernet0_0),
 	DEFINE_ZYNQ_PINCTRL_GRP(ethernet1_0),
 	DEFINE_ZYNQ_PINCTRL_GRP(mdio0_0),
-- 
1.9.1
