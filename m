From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:27:59 +0900
Subject: [PATCH v5 13/14] arm64: defconfig: add Renesas R-Car DMAC driver
 support
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446161280-23097-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d037aaaa3e02..2dc7a47a40d6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -166,6 +166,8 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
-- 
2.1.4
