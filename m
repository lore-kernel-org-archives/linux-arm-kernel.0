From: fabf@skynet.be (Fabian Frederick)
Date: Fri, 12 Aug 2016 23:47:18 +0200
Subject: [PATCH 1/1 linux-next] ARM: mvebu_v5_defconfig: use MV88E6XXX
Message-ID: <1471038438-12632-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f81ec90fe9cb
("net: dsa: mv88e6xxx: factorize the switch driver")

merged
CONFIG_NET_DSA_MV88E6131
CONFIG_NET_DSA_MV88E6123
CONFIG_NET_DSA_MV88E6171
CONFIG_NET_DSA_MV88E6352
to
CONFIG_NET_DSA_MV88E6XXX

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/arm/configs/mvebu_v5_defconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 6051c51..f7f6039 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -91,10 +91,7 @@ CONFIG_SATA_AHCI=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_DSA_MV88E6060=y
-CONFIG_NET_DSA_MV88E6131=y
-CONFIG_NET_DSA_MV88E6123=y
-CONFIG_NET_DSA_MV88E6171=y
-CONFIG_NET_DSA_MV88E6352=y
+CONFIG_NET_DSA_MV88E6XXX=y
 CONFIG_MV643XX_ETH=y
 CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
-- 
2.8.1
