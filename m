From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Feb 2018 15:17:27 -0300
Subject: [PATCH 5/5] ARM: dts: vf610m4: Remove empty reg memory property
In-Reply-To: <1519755447-9666-1-git-send-email-festevam@gmail.com>
References: <1519755447-9666-1-git-send-email-festevam@gmail.com>
Message-ID: <1519755447-9666-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

All the vf610m4 based boards include the real memory size in their
dts files, so remove the empty reg memory property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/vf610m4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
index 5d52af2..8293276 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -50,7 +50,7 @@
 	#size-cells = <1>;
 	chosen { };
 	aliases { };
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 };
 
 &mscm_ir {
-- 
2.7.4
