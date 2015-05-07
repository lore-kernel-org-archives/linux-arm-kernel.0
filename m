From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 7 May 2015 10:24:18 -0500
Subject: [RFC PATCH 0/3] PCI: host: Add PCIe host support for Hisilicon
 Soc Hip05
In-Reply-To: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
References: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <20150507152418.GM24643@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 02:04:00PM +0800, Zhou Wang wrote:
> This patchset adds PCIe host support for Hisilicon Soc Hip05. The PCIe hosts
> use PCIe IP core from Synopsys. So the driver is based on designware PCIe driver.
> 
> Zhou Wang (3):
>   PCI: host: designware: support ARM64
>   PCI: Host: Add PCIe host support for Hisilicon Soc Hip05
>   Documentation: devicetree: Add hisilicon PCIe host binding

Please run "git log" and "git log --oneline" on each file you change, and
make your changelogs and summaries look like the rest -- same style, same
capitalization, etc.

>  .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
>  drivers/pci/host/Kconfig                           |   5 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-designware.c                 |  44 +++-
>  drivers/pci/host/pcie-hisi.c                       | 252 +++++++++++++++++++++
>  5 files changed, 345 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-hisi.c
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
