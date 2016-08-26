From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:20:57 +0100
Subject: [PATCH 1/8] arm: orion5x: Add documentation for SoC and board bindings
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy the format for kirkwood/dove to orion5x

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/marvell/marvell,orion5x.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
new file mode 100644
index 0000000..a888011
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
@@ -0,0 +1,23 @@
+Marvell Orion SoC Family Device Tree Bindings
+---------------------------------------------
+
+Boards with a SoC of the Marvell Orion family, eg 88f5181
+
+* Required root node properties:
+compatible: must contain "marvell,orion5x"
+
+In addition, the above compatible shall be extended with the specific
+SoC. Currently known SoC compatibles are:
+
+"marvell,orion5x-88f5182"
+
+And in addition, the compatible shall be extended with the specific
+board. Currently known boards are:
+
+"buffalo,lsgl"
+"buffalo,lswsgl"
+"buffalo,lswtgl"
+"lacie,ethernet-disk-mini-v2"
+"lacie,d2-network"
+"marvell,rd-88f5182-nas"
+"maxtor,shared-storage-2"
-- 
2.8.1
