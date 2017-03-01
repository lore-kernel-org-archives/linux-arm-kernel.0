From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed,  1 Mar 2017 15:26:43 +0100
Subject: [PATCH 2/2] ARM: aspeed: Add CONFIG_SPI_ASPEED_SMC
In-Reply-To: <1488378403-24640-1-git-send-email-clg@kaod.org>
References: <1488378403-24640-1-git-send-email-clg@kaod.org>
Message-ID: <1488378403-24640-3-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/configs/aspeed_g4_defconfig | 3 +++
 arch/arm/configs/aspeed_g5_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index d25010e3a0bc..8bd9e6a91d41 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -40,6 +40,9 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_ASPEED_SMC=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ALACRITECH is not set
 # CONFIG_NET_VENDOR_AMAZON is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 5f660b02abd9..0eff4a53fd46 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -46,6 +46,9 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_ASPEED_SMC=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ALACRITECH is not set
 # CONFIG_NET_VENDOR_AMAZON is not set
-- 
2.7.4
