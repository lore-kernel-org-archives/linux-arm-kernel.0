From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 24 Jun 2018 16:01:08 +0200
Subject: [PATCH] soc: actions: Update SPS help text for S700
In-Reply-To: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
References: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
Message-ID: <20180624140108.13505-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3ad85b08f7789d51e6aad0f535296d1c31e319b9 (soc: actions: sps: Add S700)
added S700 support to the SPS driver but forget to update Kconfig help.

Add missing S700 mention, in preparation for further SoCs.

Fixes: 3ad85b08f778 ("soc: actions: sps: Add S700")
Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/soc/actions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index 9d68b5a771c3..56064f8859a0 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -10,7 +10,7 @@ config OWL_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support for Smart Power System (SPS)
-	  power-gating on Actions Semiconductor S500 SoC.
+	  power-gating on Actions Semiconductor S500 and S700 SoCs.
 	  If unsure, say 'n'.
 
 endif
-- 
2.16.4
