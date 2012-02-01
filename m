From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 1 Feb 2012 11:57:00 +0530
Subject: [PATCH] arm/dts: OMAP3: Add omap3evm and am335xevm support
Message-ID: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TI's OMAP3EVM and AM335xEVM are software development boards
available for OMAP35x(AM/DM37x) and AM335x devices respectively;
and these devices are considered under omap3 family.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index dbdab40..ce78498 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -41,3 +41,9 @@ Boards:

 - OMAP4 PandaBoard : Low cost community board
   compatible = "ti,omap4-panda", "ti,omap4430"
+
+- OMAP3 EVM : Software Developement Board for OMAP35x, AM/DM37x
+  compatible = "ti,omap3-evm", "ti,omap3"
+
+- AM335X EVM : Software Developement Board for AM335x
+  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
--
1.7.0.4
