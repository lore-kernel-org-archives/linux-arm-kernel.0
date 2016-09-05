From: james@innovum.com.au (James Pettigrew)
Date: Tue,  6 Sep 2016 08:15:57 +1000
Subject: [PATCH v4 2/2] devicetree: Add vendor prefix for FriendlyARM
In-Reply-To: <cover.1473112593.git.james@innovum.com.au>
References: <1472701734-1837-1-git-send-email-james@innovum.com.au>
 <cover.1473112593.git.james@innovum.com.au>
Message-ID: <eb935b967af437ed40b7efe9e4e3d7bf6fd93724.1473112593.git.james@innovum.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guangzhou FriendlyARM Computer Tech Co., Ltd is a Chinese ARM board vendor.

Signed-off-by: James Pettigrew <james@innovum.com.au>
Reviewed-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa9..7b6bda3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -98,6 +98,7 @@ ezchip	EZchip Semiconductor
 fcs	Fairchild Semiconductor
 firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
+friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
 fsl	Freescale Semiconductor
 ge	General Electric Company
 geekbuying	GeekBuying
-- 
1.9.1
