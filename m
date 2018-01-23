From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 24 Jan 2018 00:42:14 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx: add ARM power domain support
In-Reply-To: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
References: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1516725734-32745-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM power domain in PGC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
this patch should be based on 0001-ARM-dts-imx6sx-add-pu-power-domain-support.patch
 arch/arm/boot/dts/imx6sx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 42ef4c6..aa29ca6 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -768,6 +768,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					power-domain at 0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+
 					pd_pu: power-domain at 1 {
 						reg = <1>;
 						#power-domain-cells = <0>;
-- 
2.7.4
