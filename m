From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon,  7 Sep 2015 16:48:36 +0530
Subject: [PATCH-v2 2/7] mmc: sdhci-pxav3: binding: Add pxa1928 compatible
 support
In-Reply-To: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1441624721-15612-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for pxa1928 family of devices , this patch
updates the binding document with compatible property
of "marvell,pxav3-1928-sdhci".

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 3d1b449..29edcf5 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -5,7 +5,7 @@ and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
 
 Required properties:
 - compatible: Should be "mrvl,pxav2-mmc", "mrvl,pxav3-mmc" or
-  "marvell,armada-380-sdhci".
+  "marvell,armada-380-sdhci" or "marvell,pxav3-1928-sdhci".
 - reg:
   * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
     the SDHCI registers.
-- 
1.9.1
