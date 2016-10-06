From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Oct 2016 09:57:09 +0200
Subject: [PATCH v6 5/5] ARM: sunxi: Enable VGA bridge
In-Reply-To: <cover.2ec28e2292f37131839babc08427ef9f1aece26a.1475740611.git-series.maxime.ripard@free-electrons.com>
References: <cover.2ec28e2292f37131839babc08427ef9f1aece26a.1475740611.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4d4f4426feda825576d27c668d8c0c95b23b2324.1475740611.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the VGA bridge used on the A13-Olinuxino in the sunxi defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da336ec86..33b8c3308335 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -98,6 +98,7 @@ CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_SUNXI=y
 CONFIG_DRM=y
+CONFIG_DRM_SIMPLE_VGA_DAC=y
 CONFIG_DRM_SUN4I=y
 CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
-- 
git-series 0.8.10
