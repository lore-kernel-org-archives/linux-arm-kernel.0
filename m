From: marcel@ziswiler.com (marcel at ziswiler.com)
Date: Thu, 24 Nov 2016 02:04:56 +0100
Subject: [RESEND PATCH 6/6] apalis-tk1: update compatibility comment
In-Reply-To: <20161124010456.24604-1-marcel@ziswiler.com>
References: <20161124010456.24604-1-marcel@ziswiler.com>
Message-ID: <20161124010456.24604-7-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

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
2.9.3
