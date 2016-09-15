From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 16 Sep 2016 00:46:50 +0530
Subject: [PATCH v5 1/6] of: Add vendor prefix for Engicam s.r.l company
In-Reply-To: <1473967015-8523-1-git-send-email-jagan@amarulasolutions.com>
References: <1473967015-8523-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1473967015-8523-2-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
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
