From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 11 May 2018 15:29:12 -0400
Subject: [linux-next PATCH 4/4] ARM: keystone: k2g: enable micrel and dp83867
 phys
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1526066952-5230-5-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable micrel and dp83867 phys for K2G Boards in keystone_defconfig
to support Network driver on these boards (K2G ICE and GP EVM).

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 2536c23..85cf2fc 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -235,3 +235,5 @@ CONFIG_INPUT_GPIO_DECODER=m
 CONFIG_GPIO_PCA953X=m
 CONFIG_LEDS_TRIGGER_ACTIVITY=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_MICREL_PHY=y
+CONFIG_DP83867_PHY=y
-- 
1.9.1
