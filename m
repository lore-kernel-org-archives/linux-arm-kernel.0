From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 27 Jun 2017 19:30:38 -0700
Subject: Build failure in -next due to 'PCI: versatile: Convert PCI scan API
 to pci_scan_root_bus_bridge()'
Message-ID: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared
   bridge = devm_pci_alloc_host_bridge(dev, 0);

Was this code ever compiled, much less tested ?

Guenter
