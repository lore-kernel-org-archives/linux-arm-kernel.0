From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 19:08:28 +0200
Subject: [PATCH net-next v2 08/10] Documentation/bindings: net: marvell-pp2:
 add the system controller
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822170830.32413-9-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the new marvell,system-controller property used by
the Marvell ppv2 network driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 Documentation/devicetree/bindings/net/marvell-pp2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/marvell-pp2.txt b/Documentation/devicetree/bindings/net/marvell-pp2.txt
index 8918ad3ccf14..49484db81583 100644
--- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
+++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
@@ -45,6 +45,7 @@ Optional properties (port):
                    be the name associated to the interrupts listed. Valid
                    names are: "tx-cpu0", "tx-cpu1", "tx-cpu2", "tx-cpu3",
 		   "rx-shared".
+- marvell,system-controller: a phandle to the system controller.
 
 Example for marvell,armada-375-pp2:
 
-- 
2.13.5
