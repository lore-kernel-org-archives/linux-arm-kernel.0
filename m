From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 18 Aug 2017 17:58:08 +0100
Subject: [PATCH ] ARM: dts: iwg20d-q7: Add chosen node
Message-ID: <1503075488-44304-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch tested against renesas-dev tag renesas-devel-20170815-v4.13-rc5

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 081af01..305a6a1 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -19,6 +19,11 @@
 		serial0 = &scif0;
 		ethernet0 = &avb;
 	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &pfc {
-- 
1.9.1
