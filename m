From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 12:34:02 +0200
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: enable Berlin USB PHY
In-Reply-To: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444818844-2865-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This PHY is required to have the USB controller working on Berlin
and is missing from multi_v7_defconfig. Enable it.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 94d75e81ca19..2f8984618236 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -651,6 +651,7 @@ CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PWM_STI=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_PHY_BERLIN_USB=y
 CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
-- 
2.6.1
