From: marc.ceeeee@gmail.com (Marc Carino)
Date: Fri, 17 Jan 2014 11:19:24 -0800
Subject: [PATCH v4 5/8] ARM: brcmstb: add CPU binding for Broadcom Brahma15
In-Reply-To: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
References: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389986367-4010-6-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Broadcom Brahma B15 CPU to the DT CPU binding list.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 9130435..0cd1e25 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -163,6 +163,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-r4"
 			    "arm,cortex-r5"
 			    "arm,cortex-r7"
+			    "brcm,brahma-b15"
 			    "faraday,fa526"
 			    "intel,sa110"
 			    "intel,sa1100"
-- 
1.7.1
