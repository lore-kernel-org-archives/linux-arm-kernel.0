From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Sep 2012 22:53:02 +0200
Subject: [PATCH v4 5/5] arm: mvebu: add gpio support in defconfig
In-Reply-To: <1348087983-22309-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1348087983-22309-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1348087983-22309-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2e86b31..7bcf850 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -21,6 +21,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.7.9.5
