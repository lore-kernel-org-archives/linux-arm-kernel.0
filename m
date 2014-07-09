From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  9 Jul 2014 14:23:40 +0200
Subject: [PATCH 10/13] [RFC] ARM: dts: Add shmobile platform device tree
 bindings documentation
In-Reply-To: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1404908623-909-11-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
Documentation, listing supported SoCs and boards.

This allows to use checkpatch to validate DTSes referring to Renesas
shmobile SoCs, and boards containing those SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
new file mode 100644
index 000000000000..baa25c92597d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -0,0 +1,71 @@
+Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
+--------------------------------------------------------------------
+
+SoCs:
+
+  - Emma Mobile EV2
+    compatible = "renesas,emev2"
+  - RZ/A1H (R7S72100)
+    compatible = "renesas,r7s72100"
+  - R-Mobile APE6 (R8A73A40)
+    compatible = "renesas,r8a73a4"
+  - R-Mobile A1 (R8A77400)
+    compatible = "renesas,r8a7740"
+  - R-Car M1A (R8A77781)
+    compatible = "renesas,r8a7778"
+  - R-Car H1 (R8A77790)
+    compatible = "renesas,r8a7779"
+  - R-Car H2 (R8A77900)
+    compatible = "renesas,r8a7790"
+  - R-Car M2-W (R8A77910)
+    compatible = "renesas,r8a7791"
+  - R-Car V2H (R8A77920)
+    compatible = "renesas,r8a7792"
+  - R-Car M2-N (R8A77930)
+    compatible = "renesas,r8a7793"
+  - R-Car E2 (R8A77940)
+    compatible = "renesas,r8a7794"
+  - SH-Mobile AP4 (R8A73720/SH7372)
+    compatible = "renesas,sh7372"
+  - SH-Mobile AG5 (R8A73A00/SH73A0)
+    compatible = "renesas,sh73a0"
+
+
+Boards:
+
+  - Alt
+    compatible = "renesas,alt", "renesas,r8a7794"
+  - APE6-EVM
+    compatible = "renesas,ape6evm", "renesas,r8a73a4"
+  - APE6-EVM - Reference Device Tree Implementation
+    compatible = "renesas,ape6evm-reference", "renesas,r8a73a4"
+  - Atmark Techno Armadillo-800 EVA
+    compatible = "renesas,armadillo800eva"
+  - Atmark Techno Armadillo-800 EVA - Reference Device Tree Implementation
+    compatible = "renesas,armadillo800eva-reference", "renesas,r8a7740"
+  - BOCK-W
+    compatible = "renesas,bockw", "renesas,r8a7778"
+  - BOCK-W - Reference Device Tree Implementation
+    compatible = "renesas,bockw-reference", "renesas,r8a7778"
+  - Genmai (RTK772100BC00000BR)
+    compatible = "renesas,genmai", "renesas,r7s72100"
+  - Henninger
+    compatible = "renesas,henninger", "renesas,r8a7791"
+  - Koelsch (RTP0RC7791SEB00010S)
+    compatible = "renesas,koelsch", "renesas,r8a7791"
+  - EMEV2 KZM9D
+    compatible = "renesas,kzm9d", "renesas,emev2"
+  - KZM-A9-GT
+    compatible = "renesas,kzm9g", "renesas,sh73a0"
+  - KZM-A9-GT - Reference Device Tree Implementation
+    compatible = "renesas,kzm9g-reference", "renesas,sh73a0"
+  - Lager (RTP0RC7790SEB00010S)
+    compatible = "renesas,lager", "renesas,r8a7790"
+  - Mackerel (R0P7372LC0016RL, AP4 EVM 2nd)
+    compatible = "renesas,mackerel"
+  - Marzen
+    compatible = "renesas,marzen", "renesas,r8a7779"
+
+Note: Reference Device Tree Implementations are temporary implementations
+      to ease the migration from platform devices to Device Tree, and are
+      intended to be removed in the future.
-- 
1.9.1
