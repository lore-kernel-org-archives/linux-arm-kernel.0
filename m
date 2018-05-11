From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:27 +0800
Subject: [PATCH 6/9] soc: fsl: fix the compilation issue
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-6-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/soc/fsl/layerscape/ftm_alarm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c b/drivers/soc/fsl/layerscape/ftm_alarm.c
index 811dcfa..c22ef49 100644
--- a/drivers/soc/fsl/layerscape/ftm_alarm.c
+++ b/drivers/soc/fsl/layerscape/ftm_alarm.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 
 #define FTM_SC			0x00
 #define FTM_SC_CLK_SHIFT	3
-- 
1.7.1
