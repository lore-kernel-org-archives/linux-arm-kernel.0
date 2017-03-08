From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  8 Mar 2017 10:27:56 +0800
Subject: [PATCH 2/3] drm/rockchip: cdn-dp: Correct PHY register address
In-Reply-To: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
References: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1488940077-22297-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct some DP register address for PHY Configuration according to
latest datasheet.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-reg.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index 3507be3..c4bbb4a83 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -121,12 +121,11 @@
 
 /* dptx phy addr */
 #define DP_TX_PHY_CONFIG_REG		0x2000
-#define DP_TX_PHY_STATUS_REG		0x2004
-#define DP_TX_PHY_SW_RESET		0x2008
-#define DP_TX_PHY_SCRAMBLER_SEED	0x200c
-#define DP_TX_PHY_TRAINING_01_04	0x2010
-#define DP_TX_PHY_TRAINING_05_08	0x2014
-#define DP_TX_PHY_TRAINING_09_10	0x2018
+#define DP_TX_PHY_SW_RESET		0x2004
+#define DP_TX_PHY_SCRAMBLER_SEED	0x2008
+#define DP_TX_PHY_TRAINING_01_04	0x200c
+#define DP_TX_PHY_TRAINING_05_08	0x2010
+#define DP_TX_PHY_TRAINING_09_10	0x2014
 #define TEST_COR			0x23fc
 
 /* dptx hpd addr */
-- 
2.6.3
