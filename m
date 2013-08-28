From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Aug 2013 02:14:30 +0200
Subject: [PATCH RFC v2 2/6] ARM: add Marvell Berlin SoC familiy to Marvell doc
In-Reply-To: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377648874-6714-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds known facts and rumors about the Marvell Berlin (88DE3xxx) SoC
family to the Marvell SoC documentation.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- initial patch

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Documentation/arm/Marvell/README |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 8f08a86..dc0dfdd6 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -126,6 +126,28 @@ Dove family (application processor)
   Core: ARMv7 compatible
   Directory: arch/arm/mach-dove
 
+Berlin family (Digital Entertainment)
+-------------------------------------
+
+  Flavors:
+	88DE3005, Armada 1500-mini
+		Design name:	BG2-CT
+		Core:		ARM Cortex-A9, PL310 L2CC
+	88DE3010, Armada 1000
+		Design name:	unknown
+		Core:		Marvell Sheeva (possibly PJ4A/B, Tauros2/3)
+		Product Brief:	http://www.marvell.com/digital-entertainment/assets/armada_1000_pb.pdf
+	88DE3100, Armada 1500
+		Design name:	BG2
+		Core:		Marvell PJ4B (ARMv7), Tauros3 L2CC
+		Product Brief:	http://www.marvell.com/digital-entertainment/armada-1500/assets/Marvell-ARMADA-1500-Product-Brief.pdf
+	88DE????
+		Design name:	BG3
+		Core:		ARM Cortex-A15, CA15 integrated L2CC
+
+  Homepage: http://www.marvell.com/digital-entertainment/
+  Directory: arch/arm/mach-berlin
+
 PXA 2xx/3xx/93x/95x family
 --------------------------
 
-- 
1.7.2.5
