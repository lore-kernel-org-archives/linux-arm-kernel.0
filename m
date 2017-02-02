From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Feb 2017 16:51:38 +0100
Subject: [PATCHv3 net-next 09/12] net: mvpp2: fix indentation of
 MVPP2_EXT_GLOBAL_CTRL_DEFAULT
In-Reply-To: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1486050701-27899-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index ef68780..b219b0c 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -254,7 +254,7 @@
 #define MVPP2_PHY_AN_CFG0_REG			0x34
 #define     MVPP2_PHY_AN_STOP_SMI0_MASK		BIT(7)
 #define MVPP2_MNG_EXTENDED_GLOBAL_CTRL_REG	0x305c
-#define MVPP2_EXT_GLOBAL_CTRL_DEFAULT		0x27
+#define     MVPP2_EXT_GLOBAL_CTRL_DEFAULT	0x27
 
 /* Per-port registers */
 #define MVPP2_GMAC_CTRL_0_REG			0x0
-- 
2.7.4
