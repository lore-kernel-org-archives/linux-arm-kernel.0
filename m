From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:44 +0800
Subject: [PATCH 1/6] ARM: sunxi_defconfig: Enable sunxi IR driver
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A consumer IR receiver is commonly found on Allwinner SoC based
development boards and set top boxes. The driver has been available
for some time. Enable it by default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index a9a81a714be4..7d2e7bf81a47 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -92,6 +92,10 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_RC_SUPPORT=y
+CONFIG_RC_DEVICES=y
+CONFIG_IR_SUNXI=y
 CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.7.0
