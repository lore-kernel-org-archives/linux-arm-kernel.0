From: linux.amoon@gmail.com (Anand Moon)
Date: Tue,  9 Jun 2015 13:37:59 +0930
Subject: [PATCHv2] ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2 for
 Odroid-XU3
Message-ID: <1433822879-3908-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_SND_SOC_ODROIDX2 and CONFIG_SND_SIMPLE_CARD to enable
sound on Odroid-XU3 board using the max98090 audio codec.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes v2: Fixed the commit log.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9504e77..1b7253b 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -144,6 +144,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_SNOW=y
+CONFIG_SND_SOC_ODROIDX2=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.4.3
