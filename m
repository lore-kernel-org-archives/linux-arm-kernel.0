From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:50:57 +0800
Subject: [PATCH 2/9] ARM: dts: imx6qdl-sabresd: add clko1 iomux configuration
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <d2c5065c6cb9d7ed5f760e74190d0cad24cc933e.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting GPIO_0 pad as clko1 clock output to provide MCLK for WM8962.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6dl-sabresd.dts |    1 +
 arch/arm/boot/dts/imx6q-sabresd.dts  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-sabresd.dts b/arch/arm/boot/dts/imx6dl-sabresd.dts
index 7efb05d..8989df2 100644
--- a/arch/arm/boot/dts/imx6dl-sabresd.dts
+++ b/arch/arm/boot/dts/imx6dl-sabresd.dts
@@ -29,6 +29,7 @@
 				MX6DL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
 				MX6DL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
 				MX6DL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
+				MX6DL_PAD_GPIO_0__CCM_CLKO1    0x130b0
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 4420513..0038228 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -33,6 +33,7 @@
 				MX6Q_PAD_NANDF_D1__GPIO2_IO01 0x80000000
 				MX6Q_PAD_NANDF_D2__GPIO2_IO02 0x80000000
 				MX6Q_PAD_NANDF_D3__GPIO2_IO03 0x80000000
+				MX6Q_PAD_GPIO_0__CCM_CLKO1    0x130b0
 			>;
 		};
 	};
-- 
1.7.1
