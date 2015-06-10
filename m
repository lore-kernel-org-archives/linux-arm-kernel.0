From: haibo.chen@freescale.com (Haibo Chen)
Date: Wed, 10 Jun 2015 16:50:44 +0800
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: add compatible string in binding doc
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1433926244-29244-7-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string in binding doc to avoid checkpatch
warning.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 5d0376b..1c522ac 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -15,6 +15,7 @@ Required properties:
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
+	       "fsl,imx7d-usdhc"
 
 Optional properties:
 - fsl,cd-controller : Indicate to use controller internal card detection
-- 
1.9.1
