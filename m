From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 11:16:18 +0200
Subject: [PATCH 0/2] PCI: aardvark: misc improvements
Message-ID: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small set of two patches make sure the pci-aardvark driver calls
pci_bus_size_bridges() and then converts it to use pci_host_probe().

Thanks,

Thomas

Thomas Petazzoni (1):
  PCI: aardvark: Convert to use pci_host_probe()

Zachary Zhang (1):
  PCI: aardvark: Size bridges before resources allocation

 drivers/pci/controller/pci-aardvark.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

-- 
2.14.4
