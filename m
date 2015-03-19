From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 11:15:19 +0900
Subject: [PATCH 1/6] ARM: shmobile: r8a7790: add reg-names for sound
In-Reply-To: <cover.1426731062.git.horms+renesas@verge.net.au>
References: <cover.1426731062.git.horms+renesas@verge.net.au>
Message-ID: <46a158f2ce965940f68ccb07ac8127e1091bebe8.1426731062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Rensas R-Car sound driver supports reg-names.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b320252..2041ec7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1461,6 +1461,8 @@
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
 			<0 0xec541000 0 0x1280>; /* SSI */
+		reg-names = "scu", "adg", "ssiu", "ssi";
+
 		clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
 			<&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
-- 
2.1.4
