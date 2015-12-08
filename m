From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Tue,  8 Dec 2015 11:41:37 -0500
Subject: [PATCH v8 2/3] of: documentation: add bindings documentation for
 TS-4800
In-Reply-To: <1449592898-24049-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1449592898-24049-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1449592898-24049-3-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the documentation for the TS-4800 by Technologic Systems.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
new file mode 100644
index 0000000..8422988
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -0,0 +1,6 @@
+Technologic Systems Platforms Device Tree Bindings
+--------------------------------------------------
+
+TS-4800 board
+Required root node properties:
+	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
-- 
2.5.0
