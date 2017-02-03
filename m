From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri,  3 Feb 2017 13:11:51 +0100
Subject: [PATCH v2 6/8] arm64: set CONFIG_MMC_BCM2835=y in defconfig
In-Reply-To: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Message-ID: <1486123913-31705-7-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33b744d..75131a6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -391,6 +391,7 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_BCM2835=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.3.1
