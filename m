From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 11:05:43 +0200
Subject: [PATCH v7 3/3] ARM: sunxi: Enable VGA bridge
In-Reply-To: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
References: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9569fecfab89f2cfee25c899f91d388b1af0cf22.1476090316.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the VGA bridge used on the A13-Olinuxino in the sunxi defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da336ec86..dfeee5c51b40 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -98,6 +98,7 @@ CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_SUNXI=y
 CONFIG_DRM=y
+CONFIG_DRM_DUMB_VGA_DAC=y
 CONFIG_DRM_SUN4I=y
 CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
-- 
git-series 0.8.10
