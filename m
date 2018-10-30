From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 30 Oct 2018 15:28:14 +0000
Subject: [PATCH 2/2] MAINTAINERS: add maintainer for IMX LPI2C driver
In-Reply-To: <1540913007-28343-1-git-send-email-aisheng.dong@nxp.com>
References: <1540913007-28343-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540913007-28343-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPI2C is used in IMX7ULP/MX8 SoCs.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f912b..e60eaa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5845,6 +5845,14 @@ L:	linux-i2c at vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX LPI2C DRIVER
+M:	Dong Aisheng <aisheng.dong@nxp.com>
+L:	linux-i2c at vger.kernel.org
+L:	linux-imx at nxp.com
+S:	Maintained
+F:	drivers/i2c/busses/i2c-imx-lpi2c.c
+F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+
 FREESCALE IMX / MXC FEC DRIVER
 M:	Fugang Duan <fugang.duan@nxp.com>
 L:	netdev at vger.kernel.org
-- 
2.7.4
