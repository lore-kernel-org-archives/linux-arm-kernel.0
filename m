From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 17:09:29 -0700
Subject: [PATCH 08/10] dt-bindings: Add Ubiquiti Networks vendor prefix
In-Reply-To: <20170926000931.670-1-f.fainelli@gmail.com>
References: <20170926000931.670-1-f.fainelli@gmail.com>
Message-ID: <20170926000931.670-9-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the stock ticker: UBNT as the vendor prefix for Ubiquiti Networks.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1afd298eddd7..f08678fe96d9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -351,6 +351,7 @@ truly	Truly Semiconductors Limited
 tsd	Theobroma Systems Design und Consulting GmbH
 tyan	Tyan Computer Corporation
 ucrobotics	uCRobotics
+ubnt	Ubiquiti Networks
 udoo	Udoo
 uniwest	United Western Technologies Corp (UniWest)
 upisemi	uPI Semiconductor Corp.
-- 
2.14.1
