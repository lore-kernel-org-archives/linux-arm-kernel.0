From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 16:42:08 +0800
Subject: [PATCH 1/6] ASoC: mxs: add __devinit for mxs_saif_probe
In-Reply-To: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336639333-11561-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 7fd224b..40d0775 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -621,7 +621,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mxs_saif_probe(struct platform_device *pdev)
+static int __devinit mxs_saif_probe(struct platform_device *pdev)
 {
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
-- 
1.7.5.4
