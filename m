From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Mar 2014 18:01:17 +0800
Subject: [PATCH v4 4/4] ARM: prima2_defconfig: enable PWM and sirf PWM driver
In-Reply-To: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
References: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1394013677-6423-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 23591db..303204a 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -50,6 +50,8 @@ CONFIG_DMADEVICES_DEBUG=y
 CONFIG_DMADEVICES_VDEBUG=y
 CONFIG_SIRF_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_SIRF=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
1.7.5.4
