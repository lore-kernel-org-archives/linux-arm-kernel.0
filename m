From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Thu, 12 Oct 2017 17:44:46 +0800
Subject: [PATCHv2 0/2] PCI: layerscape: add fixes for layerscape-pcie errata
Message-ID: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
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

 drivers/pci/dwc/pci-layerscape.c | 11 +++++++++++
 drivers/pci/quirks.c             |  8 ++++++++
 2 files changed, 19 insertions(+)

-- 
2.14.1
