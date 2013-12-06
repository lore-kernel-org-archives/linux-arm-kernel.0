From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Dec 2013 10:41:19 +0900
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: Enable SMSC_PHY in
 defconfig
In-Reply-To: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
References: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1386294079-16392-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armadillo800eva board uses has an SMSC LAN8710A phy.
Enable SMSC_PHY in the defconfig to make use of the SMSC-specific phy
driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 5abf1a2..6162a4b 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -75,6 +75,7 @@ CONFIG_SH_ETH=y
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SMSC is not set
 # CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_SMSC_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
-- 
1.8.4
