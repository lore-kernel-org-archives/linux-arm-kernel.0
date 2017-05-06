From: anup.patel@broadcom.com (Anup Patel)
Date: Sat,  6 May 2017 17:24:36 +0530
Subject: [PATCH 01/11] dt-bindings: bcm: Add Broadcom Stingray bindings
 document
In-Reply-To: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494071686-19098-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT bindings info for Broadcom Stingray SOC
and related reference boards.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
new file mode 100644
index 0000000..23a0217
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
@@ -0,0 +1,12 @@
+Broadcom Stingray device tree bindings
+------------------------------------------------
+
+Boards with Stingray shall have the following properties:
+
+Required root node property:
+
+Stingray Combo SVK board
+compatible = "brcm,bcm958742k", "brcm,stingray";
+
+Stingray SST100 board
+compatible = "brcm,bcm958742t", "brcm,stingray";
-- 
2.7.4
