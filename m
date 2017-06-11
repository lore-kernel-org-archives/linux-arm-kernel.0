From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Jun 2017 12:03:41 +0200
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: enable the Amlogic Meson USB2
 PHY driver
In-Reply-To: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
References: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170611100343.25868-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2685e03600b1..49f038dcdd7c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -888,6 +888,7 @@ CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_QCOM_APQ8064_SATA=m
+CONFIG_PHY_MESON8B_USB2=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH407_USB=y
-- 
2.13.1
