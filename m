From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Fri, 28 Jul 2017 18:48:12 +0530
Subject: [PATCH v2 1/2] Documentation: dt: pinctrl: Add pmi8994 gpio support
Message-ID: <1501247893-30226-1-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the binding doc for qcom pmi8994-gpio devices.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

- Have been testing this patch-set on db820c for extcon with
  usb controller. The usb controller uses one of these gpios
  for usb-id/vbus detection.

Changes since v1:
 - Dropped "qcom,pmi8994-gpio" compatible addition to the driver
   since we can use the generic "qcom,spmi-gpio" compatible.
 - Sorted to add pmi8994-gpio in alphabatical order.

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 8d893a874634..d6f8adbf25c6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -16,6 +16,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8941-gpio"
 		    "qcom,pm8994-gpio"
 		    "qcom,pma8084-gpio"
+		    "qcom,pmi8994-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
 		    if the device is on an spmi bus or an ssbi bus respectively
@@ -85,6 +86,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio36 for pm8941
 		    gpio1-gpio22 for pm8994
 		    gpio1-gpio22 for pma8084
+		    gpio1-gpio10 for pmi8994
 
 - function:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
