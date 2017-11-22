From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Nov 2017 12:02:35 +0100
Subject: [PATCH v2 1/6] ARM: dts: imx6qdl-pinfunc: Add missing
 MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT
In-Reply-To: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511348560-28505-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinmux entry for OSC32K_32K_OUT on pad ENET_RXD0 used by the
Variscite DART-MX6 SoM.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/imx6dl-pinfunc.h | 1 +
 arch/arm/boot/dts/imx6q-pinfunc.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
index 0ead323..37e430a 100644
--- a/arch/arm/boot/dts/imx6dl-pinfunc.h
+++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
@@ -668,6 +668,7 @@
 #define MX6QDL_PAD_ENET_RX_ER__SPDIF_IN             0x1f4 0x5c4 0x8f0 0x3 0x1
 #define MX6QDL_PAD_ENET_RX_ER__ENET_1588_EVENT2_OUT 0x1f4 0x5c4 0x000 0x4 0x0
 #define MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24           0x1f4 0x5c4 0x000 0x5 0x0
+#define MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT        0x1f8 0x5c8 0x000 0x0 0x0
 #define MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0         0x1f8 0x5c8 0x818 0x1 0x0
 #define MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK        0x1f8 0x5c8 0x838 0x2 0x0
 #define MX6QDL_PAD_ENET_RXD0__SPDIF_OUT             0x1f8 0x5c8 0x000 0x3 0x0
diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h b/arch/arm/boot/dts/imx6q-pinfunc.h
index 9fc6120..cfb11d3 100644
--- a/arch/arm/boot/dts/imx6q-pinfunc.h
+++ b/arch/arm/boot/dts/imx6q-pinfunc.h
@@ -551,6 +551,7 @@
 #define MX6QDL_PAD_ENET_RXD1__ESAI_TX_FS            0x1e0 0x4f4 0x860 0x2 0x0
 #define MX6QDL_PAD_ENET_RXD1__ENET_1588_EVENT3_OUT  0x1e0 0x4f4 0x000 0x4 0x0
 #define MX6QDL_PAD_ENET_RXD1__GPIO1_IO26            0x1e0 0x4f4 0x000 0x5 0x0
+#define MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT        0x1e4 0x4f8 0x000 0x0 0x0
 #define MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0         0x1e4 0x4f8 0x848 0x1 0x1
 #define MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK        0x1e4 0x4f8 0x868 0x2 0x0
 #define MX6QDL_PAD_ENET_RXD0__SPDIF_OUT             0x1e4 0x4f8 0x000 0x3 0x0
-- 
2.7.4
