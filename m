From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:01 +0900
Subject: [PATCH 4/5] arm64: defconfig: add Renesas R-Car DMAC driver support
In-Reply-To: <cover.1448588763.git.horms+renesas@verge.net.au>
References: <cover.1448588763.git.horms+renesas@verge.net.au>
Message-ID: <b1f637e1d7f27cf7342e2d42f64db3ba704422ed.1448588763.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6b1e284c9f8c..f97d74081480 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -179,6 +179,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
+CONFIG_RCAR_DMAC=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
2.1.4
