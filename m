From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 05:32:27 +0000
Subject: [RFC V2 PATCH 6/8] ARM: mvebu: correct gated clock documentation
In-Reply-To: <cover.1359091286.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
Message-ID: <c72b58b396285396fbb991d5111caefbe3a3f27a.1359091286.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 7337005..cffc93d 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -89,7 +89,7 @@ ID	Clock	Peripheral
 16	xor1	XOR DMA 1
 17	crypto	CESA engine
 18	pex1	PCIe Cntrl 1
-19	ge1	Gigabit Ethernet 0
+19	ge1	Gigabit Ethernet 1
 20	tdm	Time Division Mplx
 
 Required properties:
-- 
1.8.1.1
