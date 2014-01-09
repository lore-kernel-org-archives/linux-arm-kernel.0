From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  9 Jan 2014 17:47:55 +0100
Subject: [PATCH 01/18] of: add vendor prefix for Gumstix
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1389286092-27087-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using "gumstix" for Gumstix Inc.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index edbb8d8..968a955 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -33,6 +33,7 @@ fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gmt	Global Mixed-mode Technology, Inc.
+gumstix	Gumstix, Inc.
 hisilicon	Hisilicon Limited.
 hp	Hewlett Packard
 ibm	International Business Machines (IBM)
-- 
1.8.1.2
