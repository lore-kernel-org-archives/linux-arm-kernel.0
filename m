From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  2 Oct 2017 17:44:16 +0200
Subject: [PATCH] arm64: defconfig: enable RTC on Armada 7K/8K SoCs
Message-ID: <20171002154416.585-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x RTC driver supports also the RTC controller found on the
Armada 7K/8K SoCs, so enable it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..7f6a3aee647d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -470,6 +470,7 @@ CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
+CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
-- 
2.14.1
