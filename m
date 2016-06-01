From: chanho.min@lge.com (Chanho Min)
Date: Wed, 1 Jun 2016 10:39:59 +0900
Subject: [PATCH 2/2] arm64: defconfig: Enable Cadence MACB/GEM support
In-Reply-To: <1464745199-19186-1-git-send-email-chanho.min@lge.com>
References: <1464745199-19186-1-git-send-email-chanho.min@lge.com>
Message-ID: <1464745199-19186-2-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the cadence MACB/GEM support that is needed
by lg1k SoCs.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..4edbbac 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -120,6 +120,7 @@ CONFIG_TUN=y
 CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
+CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-- 
1.7.9.5
