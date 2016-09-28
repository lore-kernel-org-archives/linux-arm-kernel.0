From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 28 Sep 2016 16:07:41 +0200
Subject: [PATCH] dt-bindings: ipmi: move all documentation under bindings/ipmi/
Message-ID: <1475071661-1342-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt         | 0
 Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt}        | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt (100%)
 rename Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt} (100%)

diff --git a/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
rename to Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
diff --git a/Documentation/devicetree/bindings/ipmi.txt b/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/ipmi.txt
rename to Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
-- 
2.7.4
