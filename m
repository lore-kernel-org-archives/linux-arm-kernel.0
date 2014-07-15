From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 15 Jul 2014 16:56:38 -0600
Subject: [PATCH 0/2] Fix GPL v2 license string typos
Message-ID: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry posted similar patches for tegra and mvebu.  These change the rest
of the occurrences in drivers/pci from:

  -MODULE_LICENSE("GPLv2");
  +MODULE_LICENSE("GPL v2");

---

Bjorn Helgaas (2):
      PCI: generic: Fix GPL v2 license string typo
      PCI: rcar: Fix GPL v2 license string typo


 drivers/pci/host/pci-host-generic.c |    2 +-
 drivers/pci/host/pcie-rcar.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
