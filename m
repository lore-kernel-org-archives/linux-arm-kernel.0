From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 08:58:58 +0200
Subject: [PATCH 2/2] PCI: tegra: Fix license string
In-Reply-To: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
"GPLv2".

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 7df5aaf58921..14ec5b2c69e0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1742,4 +1742,4 @@ module_platform_driver(tegra_pcie_driver);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.0.1
