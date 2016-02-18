From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Feb 2016 17:20:26 +0100
Subject: [PATCH v2 2/6] Documentation: arm: improve Armada 37xx description
In-Reply-To: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455812430-4656-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the introduction of other SoCs in the ARMv8 Armada
EBU family, this commit tweaks the existing description of Armada 37xx
by making the core, homepage and other informations be visible "under"
the Armada 37xx item. Indeed, the new SoCs will not share the same
core or homepage.

In addition, a link to the Product Brief is added.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 981164f..a78453b 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -128,12 +128,11 @@ EBU Armada family ARMv8
   Armada 3710/3720 Flavors:
 	88F3710
 	88F3720
+	Core: ARM Cortex A53 (ARMv8)
 
-  Core: ARM Cortex A53 (ARMv8)
-
-  Homepage     : http://www.marvell.com/embedded-processors/armada-3700/
-
-  Device tree descritpion located in arch/arm64/boot/dts/marvell/armada-37*
+	Homepage: http://www.marvell.com/embedded-processors/armada-3700/
+	Product Brief: http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+	Device tree files: arch/arm64/boot/dts/marvell/armada-37*
 
 Avanta family
 -------------
-- 
2.6.4
