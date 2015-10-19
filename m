From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Oct 2015 17:29:33 +0800
Subject: [RFC PATCH] pci:host: altera_pcie_fixups() can be static
In-Reply-To: <1445242768-4423-4-git-send-email-lftan@altera.com>
References: <201510191737.ufAp63BH%fengguang.wu@intel.com>
Message-ID: <20151019092933.GA19329@lkp-nex05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 pcie-altera.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b5e7bc2..45f03e3 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -114,7 +114,7 @@ static void altera_pcie_fixup_res(struct pci_dev *dev)
 	}
 }
 
-void altera_pcie_fixups(struct pci_bus *bus)
+static void altera_pcie_fixups(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
