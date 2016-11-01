From: scott.branden@broadcom.com (Scott Branden)
Date: Tue,  1 Nov 2016 09:37:56 -0700
Subject: [PATCH v2 1/2] mmc: sdhci-iproc: Add brcm,
 sdhci-iproc compat string in bindings document
In-Reply-To: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds brcm,sdhci-iproc compat string to DT bindings document for
the iProc SDHCI driver.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
index be56d2b..954561d 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
@@ -7,6 +7,15 @@ Required properties:
 - compatible : Should be one of the following
 	       "brcm,bcm2835-sdhci"
 	       "brcm,sdhci-iproc-cygnus"
+	       "brcm,sdhci-iproc"
+
+Use brcm2835-sdhci for Rasperry PI.
+
+Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
+restricted to 32bit host accesses to SDHCI registers.
+
+Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
+8, 16, 32-bit host access to SDHCI register.
 
 - clocks : The clock feeding the SDHCI controller.
 
-- 
2.5.0
