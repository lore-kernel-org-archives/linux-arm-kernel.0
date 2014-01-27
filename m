From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 27 Jan 2014 12:27:19 -0300
Subject: [PATCH v5 19/20] ARM: mvebu: Enable watchdog support in defconfig
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390836440-12744-20-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have proper support for Armada 370/XP watchdog
let's enable it in the defconfig.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 594d706..84ec924 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -60,6 +60,8 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_ORION_WATCHDOG=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.1.5
