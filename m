From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue, 29 Mar 2016 10:22:28 -0400
Subject: [PATCH RESEND 1/3] Documentation: dt: Add Broadcom iproc pwm
 controller binding
In-Reply-To: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1459261350-23851-2-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for Broadcom iproc pwm controller

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe..5036f63 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
 This controller has 6 channels.
 
 Required Properties :
-- compatible: should contain "brcm,kona-pwm"
+- compatible: should contain "brcm,kona-pwm" or "brcm,iproc-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a
-- 
2.1.0
