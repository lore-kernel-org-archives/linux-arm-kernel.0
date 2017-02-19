From: plaes@plaes.org (Priit Laes)
Date: Sun, 19 Feb 2017 22:27:59 +0200
Subject: [PATCH 2/4] devicetree: Add vendor prefix for Kontron AG
In-Reply-To: <20170219202801.2082-1-plaes@plaes.org>
References: <20170219202801.2082-1-plaes@plaes.org>
Message-ID: <20170219202801.2082-3-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kontron AG is a German-based company designing and manufacturing
embedded modules, computers and systems.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e..4dca895 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -154,7 +154,8 @@ jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
 keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
-kinetic Kinetic Technologies
+kinetic	Kinetic Technologies
+kontron	Kontron AG
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
-- 
2.9.3
