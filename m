From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 1 Jul 2015 18:13:48 +0900
Subject: [PATCH 4/4] ARM: tegra: Enable Nouveau in defconfig
In-Reply-To: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
References: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1435742028-8237-5-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Nouveau support is complete, enable it in the Tegra configuration
so supported boards can take advantage of it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index d199eb249151..a5ef73116fdd 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -292,3 +292,6 @@ CONFIG_EARLY_PRINTK=y
 CONFIG_CRYPTO_TWOFISH=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
+CONFIG_DRM_NOUVEAU=m
+CONFIG_NOUVEAU_DEBUG=5
+CONFIG_NOUVEAU_DEBUG_DEFAULT=3
-- 
2.4.4
