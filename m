From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  1 Nov 2016 10:36:31 -0500
Subject: [PATCH 2/3] dt-bindings: Add vendor prefix for Terasic Inc.
In-Reply-To: <20161101153632.6844-1-dinguyen@kernel.org>
References: <20161101153632.6844-1-dinguyen@kernel.org>
Message-ID: <20161101153632.6844-2-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a vendor prefix for Terasic.

http://www.terasic.com

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 81674f2..948d3ac 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -276,6 +276,7 @@ tcg	Trusted Computing Group
 tcl	Toby Churchill Ltd.
 technexion	TechNexion
 technologic	Technologic Systems
+terasic	Terasic Inc.
 thine	THine Electronics, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
-- 
2.8.3
