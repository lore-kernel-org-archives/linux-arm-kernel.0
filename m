From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Thu, 3 Mar 2016 01:48:36 +0000
Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <DBXPR04MB27013C807F30DABB9CB667D8CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Christoph Fritz [mailto:chf.fritz at googlemail.com]
> Sent: Thursday, February 25, 2016 10:48 PM
> To: Richard Zhu; Lucas Stach; Shawn Guo; Fabio Estevam; Bjorn Helgaas; Lee
> Jones
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
> 
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
> --
> 2.1.4

[Zhu hongxing]  Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
Richard
Best Regards
