From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:02 +0900
Subject: [PATCH 1/2] arm64: defconfig: Add Renesas R-Car SATA driver for R-Car
 Gen3 SoCs
In-Reply-To: <cover.1450400996.git.horms+renesas@verge.net.au>
References: <cover.1450400996.git.horms+renesas@verge.net.au>
Message-ID: <1fd6b873c2c30ff1798d9ad7985a050cd7860722.1450400996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This adds Renesas sata_rcar driver to defconfig.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2b0a9dc0ca44..93288968b8f9 100644
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
2.1.4
