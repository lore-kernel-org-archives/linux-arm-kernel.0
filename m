From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 27 Jun 2018 10:51:35 +0800
Subject: [PATCH] arm64: defconfig: enable Huawei Intelligent PCIe NIC driver
Message-ID: <1530067895-195886-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be36e61..fc6628f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -223,6 +223,7 @@ CONFIG_THUNDER_NIC_PF=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
+CONFIG_HINIC=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-- 
1.9.1
