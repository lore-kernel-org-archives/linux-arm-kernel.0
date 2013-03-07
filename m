From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:25 -0300
Subject: [PATCH 5/5] ARM: mvebu: Update defconfig to select Device Bus
 (memory-controller) support
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1362660865-2755-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..70a65f9 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -65,6 +65,8 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_MEMORY=y
+CONFIG_MVEBU_DEVBUS=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.8.6
