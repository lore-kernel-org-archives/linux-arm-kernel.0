From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 24 Aug 2015 10:47:19 +0200
Subject: [PATCH v4 2/4] mfd: max77686: Use a generic name for the PMIC node in
 the example
In-Reply-To: <1440406041-25071-1-git-send-email-javier@osg.samsung.com>
References: <1440406041-25071-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1440406041-25071-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ePAPR standard says that: "the name of a node should be somewhat
generic, reflecting the function of the device and not its precise
programming model."

So, change the max77686 binding document example to use a generic
node name instead of using the chip's name.

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Lee Jones <lee.jones@linaro.org>

---

Changes in v4:
- Add Lee Jones Acked-by tag to patch #2.

Changes in v3:
- Fix typo in ePAPR document name. Suggested by Sergei Shtylyov

Changes in v2: None

 Documentation/devicetree/bindings/mfd/max77686.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 8221102d3fc2..d2ed3c20a5c3 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -48,7 +48,7 @@ to get matched with their hardware counterparts as follow:
 
 Example:
 
-	max77686 at 09 {
+	max77686: pmic at 09 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&wakeup_eint>;
 		interrupts = <26 0>;
-- 
2.4.3
