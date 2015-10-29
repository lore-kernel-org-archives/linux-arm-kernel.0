From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:28:00 +0900
Subject: [PATCH v5 14/14] arm64: defconfig: add CS2000 driver support
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446161280-23097-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It is required from Renesas R-Car H3 Salvator-X board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2dc7a47a40d6..083c92987b17 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -171,6 +171,7 @@ CONFIG_RCAR_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.1.4
