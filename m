From: chanho.min@lge.com (Chanho Min)
Date: Mon, 9 May 2016 08:39:05 +0900
Subject: [PATCH] arm64: defconfig: Enable Cadence MACB/GEM support
Message-ID: <1462750745-11255-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the cadence MACB/GEM support that is needed
by lg1312 SoC.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 14dbe27..ed11cb6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -105,6 +105,7 @@ CONFIG_TUN=y
 CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
+CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-- 
1.7.9.5
