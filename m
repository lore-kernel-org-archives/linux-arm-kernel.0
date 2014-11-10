From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Mon, 10 Nov 2014 13:24:38 -0600
Subject: [PATCH 0/2] PCI: generic: Assiging msi-controller to PCI hostbridge
Message-ID: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces a new callback function to allow PCI host drivers
to specify MSI controller to be used for the child buses / devices.

This is reabased from:
    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-generic

Suravee Suthikulpanit (2):
  PCI: Add new pci_ops for setting MSI parent for PCI bus
  PCI: generic: Add set_msi_parent callback

 drivers/pci/host/pci-host-generic.c | 14 ++++++++++++++
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 3 files changed, 18 insertions(+)

-- 
1.9.3
