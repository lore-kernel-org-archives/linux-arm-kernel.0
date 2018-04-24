From: christophe.roullier@st.com (Christophe Roullier)
Date: Tue, 24 Apr 2018 17:01:58 +0200
Subject: [PATCH  6/8] net: stmmac: add dwmac-4.20a compatible
In-Reply-To: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1524582120-4451-7-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manage dwmac-4.20a version from synopsys

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ebd3e5f..6d141f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -472,7 +472,8 @@ struct plat_stmmacenet_data *
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a")) {
+	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
+	    of_device_is_compatible(np, "snps,dwmac-4.20a")) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
1.9.1
