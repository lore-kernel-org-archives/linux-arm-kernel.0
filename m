From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 29 Aug 2017 17:19:54 -0500
Subject: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
In-Reply-To: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <20170829221954.GT8154@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Minghuan, Mingkai, Roy]

On Fri, Aug 04, 2017 at 02:41:32PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Hou Zhiqiang (2):
>   PCI: layerscape: Add support for ls2088a
>   PCI: layerscape: Add support for ls1088a
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
>  drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
>  2 files changed, 12 insertions(+)

These still apply cleanly, but I haven't seen an ack from the driver
maintainers.

Bjorn
