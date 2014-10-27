From: smoch@web.de (Soeren Moch)
Date: Mon, 27 Oct 2014 20:10:50 +0100
Subject: [PATCH v4 1/2] devicetree: bindings: Add vendor prefix for TBS
 Technologies
In-Reply-To: <1414437051-3666-1-git-send-email-smoch@web.de>
References: <1414437051-3666-1-git-send-email-smoch@web.de>
Message-ID: <1414437051-3666-2-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TBS Technologies is a company which specializes in developing, producing
and marketing of digital TV tuner cards for PCs.

for additional details refer to http://www.tbsdtv.com/about-us.html

Signed-off-by: Soeren Moch <smoch@web.de>
Acked-by: Rob Herring <robh@kernel.org>
---
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..cdc29d4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -133,6 +133,7 @@ st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
 synology	Synology, Inc.
+tbs	TBS Technologies
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
 toradex	Toradex AG
-- 
1.9.1
