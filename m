From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 6 Nov 2015 06:40:44 +0000
Subject: [PATCH 11/12 v6] arm64: defconfig: add Renesas R-Car DMAC driver
 support
In-Reply-To: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87y4ebiqj4.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5 -> v6

 - no change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2f38277..d014f9f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -180,6 +180,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
+CONFIG_RCAR_DMAC=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
1.9.1
