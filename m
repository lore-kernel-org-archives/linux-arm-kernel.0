From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu,  3 May 2018 11:35:50 +0200
Subject: [PATCH v7 5/6] gnss: add w2sg0004 to Makefile
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Message-ID: <5eed31aa4617b100f1e8687a90f044ef873c0ab0.1525340143.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the w2sg0004 driver to the gnss framework.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gnss/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..c3c0b5548c94 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
 
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
+
+obj-$(CONFIG_GNSS_W2SG0004)		+= gnss-w2sg0004.o
+gnss-w2sg0004-y := w2sg0004.o
-- 
2.12.2
