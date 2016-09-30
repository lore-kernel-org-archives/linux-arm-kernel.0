From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 16:37:09 +0200
Subject: [PATCH v5 5/5] ARM: sunxi: Enable VGA bridge
In-Reply-To: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
References: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930143709.1388-6-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the VGA bridge used on the A13-Olinuxino in the sunxi defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da336ec86..d830e258db59 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -98,6 +98,7 @@ CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_SUNXI=y
 CONFIG_DRM=y
+CONFIG_DRM_RGB_TO_VGA=y
 CONFIG_DRM_SUN4I=y
 CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
-- 
2.9.3
