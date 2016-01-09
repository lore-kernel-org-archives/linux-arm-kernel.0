From: robh@kernel.org (Rob Herring)
Date: Sat, 9 Jan 2016 16:53:21 -0600
Subject: [PATCH v3 2/2] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
In-Reply-To: <1452297553-19911-3-git-send-email-ddaney.cavm@gmail.com>
References: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
 <1452297553-19911-3-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160109225321.GA22053@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 03:59:13PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.  Add a driver to provide these config
> space accessor functions.  The pci-host-common code is used to
> configure the PCI machinery.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   8 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
>  5 files changed, 342 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>  create mode 100644 drivers/pci/host/pci-thunder-pem.c
