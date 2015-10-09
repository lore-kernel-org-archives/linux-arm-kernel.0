From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri,  9 Oct 2015 17:57:27 +0100
Subject: [PATCH v2 3/5] of: Add vendor prefix for PLDA.
In-Reply-To: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1444409849-5685-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "plda" as vendor prefix for PLDA.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 82d2ac9..57653eb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -168,6 +168,7 @@ pericom	Pericom Technology Inc.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
+plda	PLDA
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
-- 
2.6.0
