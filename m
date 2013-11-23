From: marc.ceeeee@gmail.com (Marc C)
Date: Fri, 22 Nov 2013 17:09:20 -0800
Subject: [PATCH 2/5] ARM: brcmstb: add CPU binding for Broadcom Brahma15
Message-ID: <CAO1A-8DA6La9sx+TV1FXQ68JPpta362=VXysUUZR0Cdg72wPrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Broadcom Brahma B15 CPU to the DT CPU binding list.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..db60b3c 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -37,6 +37,7 @@ For the ARM architecture every CPU node must contain
the following properties:
  "arm,arm1156"
  "arm,arm1176"
  "arm,arm11mpcore"
+ "brcm,brahma15"
  "faraday,fa526"
  "intel,sa110"
  "intel,sa1100"
-- 
1.7.1
