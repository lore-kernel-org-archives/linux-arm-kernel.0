From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 12:34:03 +0200
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: enable pxa168 Ethernet
In-Reply-To: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444818844-2865-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell pxa168 ethernet controller is used on Berlin SoCs and is
missing from multi_v7_defconfig. Enable it.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2f8984618236..e45f80df403c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -207,6 +207,7 @@ CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_IGB=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
+CONFIG_PXA168_ETH=y
 CONFIG_KS8851=y
 CONFIG_R8169=y
 CONFIG_SH_ETH=y
-- 
2.6.1
