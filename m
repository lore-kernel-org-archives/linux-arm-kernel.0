From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Aug 2012 15:31:46 +0200
Subject: [PATCH 5/5] arm: mvebu: add gpio support in defconfig
In-Reply-To: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344691906-15985-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
index cb07e64..8dbb0bf 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -23,6 +23,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_PINCTRL_ARMADA_370=y
 CONFIG_PINCTRL_ARMADA_XP=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.7.9.5
