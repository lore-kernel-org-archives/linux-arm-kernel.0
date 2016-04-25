From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Apr 2016 15:46:11 +0200
Subject: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
In-Reply-To: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160425154611.3e7e9dc9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 14 Apr 2016 17:36:15 +0200, Thomas Petazzoni wrote:

> Thomas Petazzoni (2):
>   dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
>     controller
>   pci: host: new driver for Marvell Armada 7K/8K PCIe controller
> 
>  .../devicetree/bindings/pci/pci-armada8k.txt       |  38 +++
>  drivers/pci/host/Kconfig                           |  11 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-armada8k.c                   | 261 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  create mode 100644 drivers/pci/host/pcie-armada8k.c

Bjorn, any comment about this additional PCIe host driver? The
corresponding Device Tree binding has been approved by Rob Herring. The
driver itself is fairly trivial as it relies on the common Designware
logic.

DO not hesitate to let me know if any adaptation/change is needed. I'd
really like to have this merged for the 4.7 merge window.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
