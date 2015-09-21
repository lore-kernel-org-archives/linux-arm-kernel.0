From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 18:04:18 +0800
Subject: [PATCH v2 4/6] pinctrl: dt-binding: document berlin4ct SoC pinctrl
In-Reply-To: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
References: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442829860-4647-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add berlin4ct to existing berlin pinctrl device tree binding.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
index a8bb5e2..0580860 100644
--- a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
@@ -20,7 +20,10 @@ Required properties:
 	"marvell,berlin2cd-soc-pinctrl",
 	"marvell,berlin2cd-system-pinctrl",
 	"marvell,berlin2q-soc-pinctrl",
-	"marvell,berlin2q-system-pinctrl"
+	"marvell,berlin2q-system-pinctrl",
+	"marvell,berlin4ct-avio-pinctrl",
+	"marvell,berlin4ct-sm-pinctrl",
+	"marvell,berlin4ct-soc-pinctrl"
 
 Required subnode-properties:
 - groups: a list of strings describing the group names.
-- 
2.5.3
