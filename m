From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 15:34:43 -0700
Subject: [PATCH 1/2] of: Add vendor prefix for Asahi Kasei Corp.
Message-ID: <1353364484-5741-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Their stock ticker is 3407.T which wouldn't make a good DT vendor
prefix. Use the company name initials instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Both patches ought to merge through the DT tree OK. If not, patch 2
could be taken through arm-soc.

 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index deba8d0..05dc8eb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -5,6 +5,7 @@ using them to avoid name-space collisions.
 
 ad	Avionic Design GmbH
 adi	Analog Devices, Inc.
+ak	Asahi Kasei Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 apm	Applied Micro Circuits Corporation (APM)
 arm	ARM Ltd.
-- 
1.7.10.4
