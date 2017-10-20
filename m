From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 20 Oct 2017 13:28:45 -0500
Subject: [PATCHv2 0/2] PCI: layerscape: add fixes for layerscape-pcie
 errata
In-Reply-To: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
References: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20171020182845.GM6332@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 05:44:46PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The [1/2] is to fix layerscape PCIe MSI/MSI-X capability errata.
> The [2/2] is to change the default AXI system error response behavior
> for PCI Express outbound non-posted requests.
> 
> Hou Zhiqiang (1):
>   PCI: Disable MSI for Freescale PCIe RC mode
> 
> Minghuan Lian (1):
>   pci/layerscape: change the default error response behavior
> 
>  drivers/pci/dwc/pci-layerscape.c | 11 +++++++++++
>  drivers/pci/quirks.c             |  8 ++++++++
>  2 files changed, 19 insertions(+)

Applied to pci/host-layerscape for v4.15, thanks!
