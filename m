From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Oct 2014 23:13:32 +0100
Subject: [PATCH 3/4] ARM: mvebu: Add DLINK DIR665 options to mvebu_v5_defconfig
In-Reply-To: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
Message-ID: <1414793613-11798-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building of the switch chip driver and the wireless driver
needed by the DLINK DIR665

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 22058e18dfaa..824de499237b 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -67,9 +67,11 @@ CONFIG_SATA_AHCI=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_DSA_MV88E6123_61_65=y
+CONFIG_NET_DSA_MV88E6171=y
 CONFIG_MV643XX_ETH=y
 CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
+CONFIG_MWL8K=m
 CONFIG_LIBERTAS=y
 CONFIG_LIBERTAS_SDIO=y
 CONFIG_INPUT_EVDEV=y
-- 
2.1.1
