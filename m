From: liudongdong3@huawei.com (Dongdong Liu)
Date: Thu, 30 Aug 2018 20:29:32 +0800
Subject: [PATCH] arm64: defconfig: Enable PCIEPORTBUS
Message-ID: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe features like AER, Hotplug, PME, DPC depend on PCIEPORTBUS,
so enable PCIEPORTBUS as default.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5..e5652e9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -67,6 +67,7 @@ CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_IOV=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
-- 
1.9.1
