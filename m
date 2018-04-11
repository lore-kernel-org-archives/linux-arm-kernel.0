From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 11 Apr 2018 22:10:36 +0530
Subject: [PATCH 4/4] soc: actions: Fix help text in Kconfig for OWL_PM_DOMAINS
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180411164036.8046-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OWL_PM_DOMAINS is being used by 3 SoCs of OWL family. This fixes
the wording to use family name OWL instead of SoC name S500.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/actions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index 9d68b5a771c3..26c3155d3738 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -10,7 +10,7 @@ config OWL_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support for Smart Power System (SPS)
-	  power-gating on Actions Semiconductor S500 SoC.
+	  power-gating on Actions Semiconductor OWL SoCs.
 	  If unsure, say 'n'.
 
 endif
-- 
2.14.1
