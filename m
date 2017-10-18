From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Wed, 18 Oct 2017 17:46:20 +0300
Subject: [PATCH] arm64: defconfig: Enable Tegra PCI controller
Message-ID: <20171018144620.4699-1-tuomas.tynkkynen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has supported the 64-bit Tegra210 for a while now, so enable
it in the defconfig.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
I didn't personally test this but got a report from our distro users
that it works.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 719602300d9b..21c173fcbc3c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -74,6 +74,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
+CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR=y
 CONFIG_PCIE_ROCKCHIP=m
 CONFIG_PCI_HOST_GENERIC=y
-- 
2.14.2
