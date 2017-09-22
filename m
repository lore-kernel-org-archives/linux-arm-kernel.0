From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Fri, 22 Sep 2017 15:25:20 +0800
Subject: [PATCH 0/2] PCI: layerscape: add fixes for layerscape-pcie errata
Message-ID: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The [1/2] is to fix layerscape PCIe MSI/MSI-X capability errata.
The [2/2] is to change the default AXI system error response behavior
for PCI Express outbound non-posted requests.

Hou Zhiqiang (1):
  PCI: Disable MSI for Freescale PCIe RC mode

Minghuan Lian (1):
  pci/layerscape: change the default error response behavior

 drivers/pci/dwc/pci-layerscape.c | 25 +++++++++++++++++++++++++
 drivers/pci/quirks.c             |  8 ++++++++
 2 files changed, 33 insertions(+)

-- 
2.14.1
