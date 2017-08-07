From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 22:31:56 +0800
Subject: [PATCH 1/5] arm64: defconfig: enable Kirin PCIe
In-Reply-To: <20170807143200.6764-1-guodong.xu@linaro.org>
References: <20170807143200.6764-1-guodong.xu@linaro.org>
Message-ID: <20170807143200.6764-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaowei Song <songxiaowei@hisilicon.com>

Enable HiSilicon Kirin series SoCs PCIe controllers

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b4ca115..4e14c6d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,7 @@ CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
+CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCIE_RCAR=y
-- 
2.10.2
