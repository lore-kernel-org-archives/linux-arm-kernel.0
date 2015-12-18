From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:03 +0900
Subject: [PATCH 2/2] arm64: defconfig: add CS2000 support
In-Reply-To: <cover.1450400996.git.horms+renesas@verge.net.au>
References: <cover.1450400996.git.horms+renesas@verge.net.au>
Message-ID: <d3643e1669e59c374e78e3af9d93def5ac1f81bc.1450400996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 93288968b8f9..bdbe783584ec 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -190,6 +190,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
2.1.4
