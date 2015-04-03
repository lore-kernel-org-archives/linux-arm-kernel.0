From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:39:58 -0500
Subject: [PATCH 7/7] Documentation: DT bindings: add doc for Altera's SoCFPGA
 platform
In-Reply-To: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1428035998-27542-8-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Document "altr,socfpga-cyclone5", "altr,socfpga-arria5", and
"altr,socfpga-arria10".

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 Documentation/devicetree/bindings/arm/altera.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera.txt

diff --git a/Documentation/devicetree/bindings/arm/altera.txt b/Documentation/devicetree/bindings/arm/altera.txt
new file mode 100644
index 0000000..558735a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera.txt
@@ -0,0 +1,14 @@
+Altera's SoCFPGA platform device tree bindings
+---------------------------------------------
+
+Boards with Cyclone 5 SoC:
+Required root node properties:
+compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+Boards with Arria 5 SoC:
+Required root node properties:
+compatible = "altr,socfpga-arria5", "altr,socfpga";
+
+Boards with Arria 10 SoC:
+Required root node properties:
+compatible = "altr,socfpga-arria10", "altr,socfpga";
-- 
2.2.1
