From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  5 Nov 2014 20:02:01 +0100
Subject: [PATCH 3/3] mvebu: defconfig: Enable the mv88E6171 switch driver
In-Reply-To: <1415214121-29286-1-git-send-email-andrew@lunn.ch>
References: <1415214121-29286-1-git-send-email-andrew@lunn.ch>
Message-ID: <1415214121-29286-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switch is used by the 370-rd. Enable it and support for
fixed-link phy configuration.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index ed0a0d1be0f3..8548eee5cbeb 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -59,10 +59,12 @@ CONFIG_ATA=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
+CONFIG_NET_DSA_MV88E6171=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
 CONFIG_MVPP2=y
 CONFIG_MARVELL_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_MWIFIEX=y
 CONFIG_MWIFIEX_SDIO=y
 CONFIG_INPUT_EVDEV=y
-- 
2.1.3
