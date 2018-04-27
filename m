From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 27 Apr 2018 10:40:01 +0800
Subject: [PATCH v6 7/7] arm64: defconfig: update config for Rockchip PCIe
In-Reply-To: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1524796801-161426-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now Rockchip PCIe drivers could support both of host mode
and endponint mode, so we rename the config name. This patch
updates defconfig to refect the fact that we want to build
Rockchip PCIe controller driver into a module as before.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0d8ae1d..5cf70af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -79,7 +79,8 @@ CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR=y
-CONFIG_PCIE_ROCKCHIP=m
+CONFIG_PCIE_ROCKCHIP=y
+CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
-- 
1.9.1
