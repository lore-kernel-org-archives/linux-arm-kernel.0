From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:28 -0700
Subject: [PATCH 02/15] pinctrl: sunxi: Drop unused structure members
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ranges and nranges were never used. Remove them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index 90040accb11c..4e24b9b5f12e 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -448,8 +448,6 @@ struct sunxi_desc_pin {
 struct sunxi_pinctrl_desc {
 	const struct sunxi_desc_pin	*pins;
 	int				npins;
-	struct pinctrl_gpio_range	*ranges;
-	int				nranges;
 	unsigned			pin_base;
 };
 
-- 
1.9.1
