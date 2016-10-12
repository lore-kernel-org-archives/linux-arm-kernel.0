From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 12 Oct 2016 11:35:51 -0700
Subject: [PATCH 1/2] mmc: sdhci-iproc: Add brcm,
 sdhci-iproc compat string in bindings document
In-Reply-To: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1476297352-7812-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds brcm,sdhci-iproc compat string to DT bindings document for
the iProc SDHCI driver.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
index be56d2b..aa58b94 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible : Should be one of the following
 	       "brcm,bcm2835-sdhci"
 	       "brcm,sdhci-iproc-cygnus"
+	       "brcm,sdhci-iproc"
 
 - clocks : The clock feeding the SDHCI controller.
 
-- 
2.5.0
