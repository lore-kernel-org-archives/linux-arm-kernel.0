From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 17:09:25 -0700
Subject: [PATCH 04/10] dt-bindings: Document Broadcom Hurricane 2 clocks
In-Reply-To: <20170926000931.670-1-f.fainelli@gmail.com>
References: <20170926000931.670-1-f.fainelli@gmail.com>
Message-ID: <20170926000931.670-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Device Tree binding document for the Broadcom Hurricane 2 SoC
which is an iProc based system.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/clock/brcm,iproc-clocks.txt        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
index f2c5f0e4a363..f8e4a93466cb 100644
--- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
@@ -137,6 +137,20 @@ These clock IDs are defined in:
     ch1_audio  audiopll         2       BCM_CYGNUS_AUDIOPLL_CH1
     ch2_audio  audiopll         3       BCM_CYGNUS_AUDIOPLL_CH2
 
+Hurricane 2
+------
+PLL and leaf clock compatible strings for Hurricane 2 are:
+ "brcm,hr2-armpll"
+
+The following table defines the set of PLL/clock for Hurricane 2:
+
+    Clock	Source		Index	ID
+    ---		-----		-----	---------
+    crystal	N/A		N/A	N/A
+
+    armpll	crystal		N/A	N/A
+
+
 Northstar and Northstar Plus
 ------
 PLL and leaf clock compatible strings for Northstar and Northstar Plus are:
-- 
2.14.1
