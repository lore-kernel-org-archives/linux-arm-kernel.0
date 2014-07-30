From: rric@kernel.org (Robert Richter)
Date: Wed, 30 Jul 2014 17:06:34 +0200
Subject: [PATCH 5/5] arm64, defconfig: Enable tmpfs mount option
In-Reply-To: <1406732794-20920-1-git-send-email-rric@kernel.org>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
Message-ID: <1406732794-20920-6-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Making it more convinient to run the arm64 default kernel as distros
like Ubuntu need this option.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 26c3ab582db5..50ea69d51bb4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -55,6 +55,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
-- 
2.0.1
