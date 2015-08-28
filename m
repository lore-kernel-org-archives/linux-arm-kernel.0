From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:36 +0200
Subject: [PATCH 01/11] arm: tegra: colibri_t30: update hardware revisions
 compatible comment
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-2-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update introductory comment about what exact hardware revisions this
device tree is compatible with as a hint for our customers.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..83ba3f2 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -2,8 +2,8 @@
 #include "tegra30.dtsi"
 
 /*
- * Toradex Colibri T30 Device Tree
- * Compatible for Revisions 1.1B/1.1C/1.1D
+ * Toradex Colibri T30 Module Device Tree
+ * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E; IT: V1.1A
  */
 / {
 	model = "Toradex Colibri T30";
-- 
2.4.3
