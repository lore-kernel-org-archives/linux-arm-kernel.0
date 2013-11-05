From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  5 Nov 2013 15:28:39 +0100
Subject: [PATCH v3 5/9] ARM: add Marvell Berlin SoCs to multi_v7_defconfig
In-Reply-To: <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1383661723-17956-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Marvell Berlin SoC family, Marvell Armada 1500
(BG2), and Marvell Armada 1500-mini (BG2CD) to the multi_v7_defconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
Changelog:
v2->v3:
- also add BG2CD (Armada 1500-mini)
v1->v2:
- replace 88DE3xxx numbering with SoC variant name
  (Requested by Jisheng Zhang)

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/configs/multi_v7_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 119fc37..f3e825f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,9 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BERLIN=y
+CONFIG_MACH_BERLIN_BG2=y
+CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_KEYSTONE=y
-- 
1.7.10.4
