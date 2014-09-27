From: romain.perier@gmail.com (Romain Perier)
Date: Sat, 27 Sep 2014 16:21:46 +0000
Subject: [PATCH v1 3/3] dt-bindings: Document the property
 system-power-controller for act8865 regulator
In-Reply-To: <1411834906-9533-1-git-send-email-romain.perier@gmail.com>
References: <1411834906-9533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1411834906-9533-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/regulator/act8865-regulator.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 865614b..653ddc1 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -5,6 +5,10 @@ Required properties:
 - compatible: "active-semi,act8846" or "active-semi,act8865"
 - reg: I2C slave address
 
+Optional properties:
+- active-semi,system-power-controller: Telling whether or not this pmic is controlling
+  the system power
+
 Any standard regulator properties can be used to configure the single regulator.
 
 The valid names for regulators are:
-- 
1.9.1
