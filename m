From: bd-phuc@jinso.co.jp (bd-phuc at jinso.co.jp)
Date: Fri,  9 Sep 2016 20:43:07 +0900
Subject: [PATCH 1/8] devicetree: binding: R-car Gen3 CMT0 and CMT1 bindings
In-Reply-To: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <1473421394-9745-2-git-send-email-bd-phuc@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

Add documentation for new separate CMT0 and CMT1 DT compatible strings
for R-Car Gen3.

Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 1a05c1b..72fd526 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -52,6 +52,8 @@ Required Properties:
 		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
 		This is a fallback for the renesas,cmt-48-r8a73a4,
 		renesas,cmt-48-r8a7790 and renesas,cmt-48-r8a7791 entries.
+    - "renesas,cmt-48-gen3" for third generation 48-bit CMT
+		(CMT[01] on r8a7795 and r8a7796)
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.7.4
