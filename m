From: jteki@openedev.com (Jagan Teki)
Date: Tue, 27 Sep 2016 00:55:31 +0530
Subject: [PATCH v6 1/6] of: Add vendor prefix for Engicam s.r.l company
Message-ID: <1474917937-29336-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Engicam providing design services of electronic systems with
high content of technology, relying on a long experience in
electronic design.

For more info visit
http://www.engicam.com/en/

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
	- Added Acked-by: tag
Changes for v5:
        - none
Changes for v4:
        - new patch

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3003f33..327e4c7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -85,6 +85,7 @@ elan	Elan Microelectronic Corp.
 embest	Shenzhen Embest Technology Co., Ltd.
 emmicro	EM Microelectronic
 energymicro	Silicon Laboratories (formerly Energy Micro AS)
+engicam	Engicam S.r.l.
 epcos	EPCOS AG
 epfl	Ecole Polytechnique F?d?rale de Lausanne
 epson	Seiko Epson Corp.
-- 
2.7.4
