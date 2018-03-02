From: jglauber@cavium.com (Jan Glauber)
Date: Fri,  2 Mar 2018 15:37:36 +0100
Subject: [PATCH 1/2] arm64: defconfig: enable THUNDER_NIC_VF
Message-ID: <20180302143737.10788-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this option the NIC on ThunderX1 is not coming up
so enable it to get a working network interface.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373785c4..3594aefa496f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -197,6 +197,7 @@ CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_THUNDER_NIC_VF=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
-- 
2.7.4
