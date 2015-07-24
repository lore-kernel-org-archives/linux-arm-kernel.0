From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Fri, 24 Jul 2015 18:12:14 +0800
Subject: [PATCH v12 2/6] devicetree: Add NEC to the vendor-prefix list
In-Reply-To: <1437732738-4960-1-git-send-email-jianwei.wang.chn@gmail.com>
References: <1437732738-4960-1-git-send-email-jianwei.wang.chn@gmail.com>
Message-ID: <1437732738-4960-3-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NEC represent NEC LCD Technologies, Ltd.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..9f22b3e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -131,6 +131,7 @@ mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
+nec	NEC LCD Technologies, Ltd.
 neonode		Neonode Inc.
 netgear	NETGEAR
 netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
-- 
2.1.0.27.g96db324
