From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 May 2014 16:06:05 +0800
Subject: [PATCH v6 09/15] document: dt: add the binding on HiP04 clock
In-Reply-To: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399795571-17231-10-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT binding for Hisilicon HiP04 clock driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/clock/hip04-clock.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/hip04-clock.txt b/Documentation/devicetree/bindings/clock/hip04-clock.txt
new file mode 100644
index 0000000..4d31ae3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hip04-clock.txt
@@ -0,0 +1,20 @@
+* Hisilicon HiP04 Clock Controller
+
+The HiP04 clock controller generates and supplies clock to various
+controllers within the HiP04 SoC.
+
+Required Properties:
+
+- compatible: should be one of the following.
+  - "hisilicon,hip04-clock" - controller compatible with HiP04 SoC.
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- #clock-cells: should be 1.
+
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hip04-clock.h>.
-- 
1.9.1
