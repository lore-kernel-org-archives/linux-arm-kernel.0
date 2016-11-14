From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 14 Nov 2016 10:42:50 +0100
Subject: [PATCH] ARM64: configs: Activate Internal PHY for Meson GXL
In-Reply-To: <20161107104357.24428-1-narmstrong@baylibre.com>
References: <20161107104357.24428-1-narmstrong@baylibre.com>
Message-ID: <20161114094250.25059-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..3890321 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -183,7 +183,10 @@ CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=m
 CONFIG_REALTEK_PHY=m
+CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
+CONFIG_MDIO_BUS_MUX=y
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
-- 
1.9.1
