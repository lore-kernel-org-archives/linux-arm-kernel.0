From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:02 +0100
Subject: [PATCH v3 05/18] dt-bindings: vendor-prefixes: Add PLX Technology
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PLX Technology vendor prefix.
Fixed "pixdir" alphabetizing.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 42adb41..24b2100 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -180,9 +180,10 @@ parade	Parade Technologies Inc.
 pericom	Pericom Technology Inc.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
-pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+plxtech	PLX Technology, Inc.
 pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
-- 
1.9.1
