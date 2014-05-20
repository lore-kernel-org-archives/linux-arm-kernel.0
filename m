From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 20 May 2014 11:04:30 +0200
Subject: [PATCH v4 2/7] Documentation: bindings: add the Berlin SATA PHY
In-Reply-To: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400576675-25265-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin SATA PHY drives the PHY related to the SATA interface. Add
the corresponding documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..72646db2f5fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,14 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: "marvell,berlin-sata-phy"
+- phy-cells: from the generic PHY bindings, must be 1
+- reg: address and length of the register
+
+Example:
+	sata_phy: phy at f7e900a0 {
+		compatible = "marvell,berlin-sata-phy";
+		reg = <0xf7e900a0 0x200>;
+		#phy-cells = <1>;
+	};
-- 
1.9.1
