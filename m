From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Oct 2014 23:13:33 +0100
Subject: [PATCH 4/4] ARM: config: Add DLINK DIR665 options to
 multi_v5_defconfig
In-Reply-To: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
Message-ID: <1414793613-11798-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building of the switch chip driver and the wireless driver
needed by the DLINK DIR665

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: arm at kernel.org
---
 arch/arm/configs/multi_v5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 018bef9fa7e8..9d56781a8f80 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
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
