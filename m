From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 16 Oct 2015 15:37:10 +0800
Subject: [PATCH v6 5/7] pinctrl: dt-binding: document berlin4ct SoC pinctrl
In-Reply-To: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
References: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444981032-4401-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add berlin4ct to existing berlin pinctrl device tree binding.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
index a8bb5e2..f8fa28c 100644
--- a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
@@ -20,7 +20,10 @@ Required properties:
 	"marvell,berlin2cd-soc-pinctrl",
 	"marvell,berlin2cd-system-pinctrl",
 	"marvell,berlin2q-soc-pinctrl",
-	"marvell,berlin2q-system-pinctrl"
+	"marvell,berlin2q-system-pinctrl",
+	"marvell,berlin4ct-avio-pinctrl",
+	"marvell,berlin4ct-soc-pinctrl",
+	"marvell,berlin4ct-system-pinctrl"
 
 Required subnode-properties:
 - groups: a list of strings describing the group names.
-- 
2.6.1
