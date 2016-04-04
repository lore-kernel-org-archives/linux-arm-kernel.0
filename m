From: j-keerthy@ti.com (Keerthy)
Date: Mon, 4 Apr 2016 23:59:03 +0530
Subject: [PATCH 2/2] ARM: configs: keystone: Add CPU Hotplug related options
In-Reply-To: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
References: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1459794543-4822-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the config options needed to get CPU hotplug functional.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 5bcc9cf..faba04d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -30,6 +30,8 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_KEYSTONE=y
 CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_ARM_PSCI=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-- 
1.9.1
