From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 20 Oct 2015 16:50:07 -0500
Subject: [PATCH 3/5] ARM: keystone: defconfig: Enable PINCTRL SINGLE for
 Keystone 2
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Message-ID: <1445377809-12516-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer Keystone 2 devices utilize pinmuxing. Enable PINCTRL SINGLE
which is used to handle pinmuxing.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 95ce128..e0e0365 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -208,3 +208,4 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_TI_DAVINCI_MDIO=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DEVTMPFS=y
+CONFIG_PINCTRL_SINGLE=y
-- 
2.6.1
