From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 10 Aug 2017 10:37:28 +0800
Subject: [PATCH v2 6/6] arm64: defconfig: enable DMA driver for hi3660
In-Reply-To: <20170810023728.19621-1-guodong.xu@linaro.org>
References: <20170810023728.19621-1-guodong.xu@linaro.org>
Message-ID: <20170810023728.19621-7-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Ruyi <wangruyi@huawei.com>

enable DMA driver for hi3660.

Signed-off-by: Wang Ruyi <wangruyi@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 81008e1..ab085d0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -457,6 +457,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=m
+CONFIG_K3_DMA=y
 CONFIG_MV_XOR_V2=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
-- 
2.10.2
