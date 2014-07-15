From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 15 Jul 2014 16:56:45 -0600
Subject: [PATCH 1/2] PCI: generic: Fix GPL v2 license string typo
In-Reply-To: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140715225645.22578.64865.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".

Based-on-work-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 44fe6aa6a43f..3d2076f59911 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -385,4 +385,4 @@ module_platform_driver(gen_pci_driver);
 
 MODULE_DESCRIPTION("Generic PCI host driver");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
