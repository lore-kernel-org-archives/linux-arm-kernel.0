From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:18:31 +0200
Subject: [PATCH 10/24] ste_dma40: Adjust the position of a jump label in
 d40_probe()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <9a11dcf4-3bab-d5f9-2128-0eaa6560cfff@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 14:36:26 +0200

Add a space character before a single jump label in this function
according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index ebb00a8..4ebc825 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3728,7 +3728,7 @@ failure:
 	kfree(base->lookup_phy_chans);
 	kfree(base->phy_res);
 	kfree(base);
-report_failure:
+ report_failure:
 	d40_err(&pdev->dev, "probe failed\n");
 	return ret;
 }
-- 
2.10.0
