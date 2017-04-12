From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 12 Apr 2017 11:02:58 -0500
Subject: [PATCH 6/8] arm64: defconfig: enable support for PCIe hotplug
In-Reply-To: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
References: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
Message-ID: <1492012980-11650-7-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM64 server systems support PCIe hotplug, so enable the options
for that.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cdc8698..5f50213 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -61,7 +61,10 @@ CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
+CONFIG_HOTPLUG_PCI_PCIE=y
 CONFIG_PCI_IOV=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
