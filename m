From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Thu, 03 Mar 2016 02:41:21 +0100
Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1456969281.2246.0.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*ping*

On Thu, 2016-02-25 at 15:47 +0100, Christoph Fritz wrote:
> v3:
>  * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
> v2:
>  * leave out regulator handling from driver, will be done later
>    in PM subsystem 
>  * use BIT() macro for MFD
> 
> Christoph Fritz (2):
>   MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
>   PCI: imx6: add initial imx6sx support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
>  3 files changed, 101 insertions(+), 40 deletions(-)
> 
