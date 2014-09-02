From: dianders@chromium.org (Doug Anderson)
Date: Tue,  2 Sep 2014 09:14:29 -0700
Subject: [PATCH 2/2] dt-bindings: Add input supplies to rk808 bindings
In-Reply-To: <1409674469-12123-1-git-send-email-dianders@chromium.org>
References: <1409674469-12123-1-git-send-email-dianders@chromium.org>
Message-ID: <1409674469-12123-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original bindings for rk808 didn't include input supplies.  Add
them.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index f8932ac..283a906 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -13,6 +13,17 @@ Optional properties:
   default output clock name
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc6-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc7-supply:  The input supply for LDO_REG3 and LDO_REG7
+- vcc8-supply:  The input supply for SWITCH_REG1
+- vcc9-supply:  The input supply for LDO_REG4 and LDO_REG5
+- vcc10-supply: The input supply for LDO_REG6
+- vcc11-supply: The input supply for LDO_REG8
+- vcc12-supply: The input supply for SWITCH_REG2
 
 Regulators: All the regulators of RK808 to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
-- 
2.1.0.rc2.206.gedb03e5
