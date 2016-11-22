From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 22 Nov 2016 01:14:07 +0100
Subject: [PATCH 6/6] apalis-tk1: update compatibility comment
In-Reply-To: <1479773647-14726-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1479773647-14726-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1479773647-14726-7-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with the new V1.1A HW card detect being implemented update resp.
compatibility information.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 2bfc579..2276073 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -44,7 +44,7 @@
 
 /*
  * Toradex Apalis TK1 Module Device Tree
- * Compatible for Revisions 2GB: V1.0A
+ * Compatible for Revisions 2GB: V1.0A, V1.0B, V1.1A
  */
 / {
 	model = "Toradex Apalis TK1";
-- 
2.5.5
