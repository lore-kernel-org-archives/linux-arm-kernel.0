From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:49 +0300
Subject: [PATCH v2 07/10] staging: fsl-mc: add binding path to MAINTAINERS
In-Reply-To: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
Message-ID: <20170531105852.22304-8-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The mc bus device tree binding is maintained but
not mentioned in the MAINTAINERS file. This patch
adds it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---

Notes:
  -v2
   -added commit description

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e98464..ffac090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10545,6 +10545,7 @@ M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel at vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-mc/
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.9.4
