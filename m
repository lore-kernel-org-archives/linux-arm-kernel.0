From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  7 Jul 2014 15:45:51 -0300
Subject: [PATCH v3 4/4] ARM: mvebu: enable Armada 375 network driver in
 mvebu_v7_defconfig
In-Reply-To: <1404758751-2346-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1404758751-2346-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1404758751-2346-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

Now that the Armada 375 network driver has been pushed, let's enable it
in mvebu_v7_defconfig.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index b0bfefa..b477631 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -46,6 +46,7 @@ CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_MVNETA=y
+CONFIG_MVPP2=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MWIFIEX=y
 CONFIG_MWIFIEX_SDIO=y
-- 
1.9.1
