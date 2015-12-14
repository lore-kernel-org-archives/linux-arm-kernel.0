From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 14 Dec 2015 16:42:38 +0100
Subject: [PATCH 6/6] arm64: defconfig: Add Renesas R-Car SATA driver for R-Car
 Gen3 SoCs
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450107758-2544-7-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This adds Renesas sata_rcar driver to defconfig.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f239a2e..bdbe783 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -93,6 +93,7 @@ CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_XGENE=y
+CONFIG_SATA_RCAR=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
 CONFIG_NETDEVICES=y
-- 
2.6.3
