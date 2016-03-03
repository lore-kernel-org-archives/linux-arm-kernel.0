From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Thu, 3 Mar 2016 01:46:02 +0000
Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
In-Reply-To: <1456969281.2246.0.camel@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
 <1456969281.2246.0.camel@googlemail.com>
Message-ID: <DBXPR04MB2708AB0A3F95E78580FC7408CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Christoph Fritz [mailto:chf.fritz at googlemail.com]
> Sent: Thursday, March 03, 2016 9:41 AM
> To: Richard Zhu; Shawn Guo; Lucas Stach
> Cc: Fabio Estevam; Bjorn Helgaas; Lee Jones; linux-pci at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 0/2] Add PCIe driver support for imx6sx
> 
> *ping*
> 
> On Thu, 2016-02-25 at 15:47 +0100, Christoph Fritz wrote:
> > v3:
> >  * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
> > v2:
> >  * leave out regulator handling from driver, will be done later
> >    in PM subsystem
> >  * use BIT() macro for MFD
> >
> > Christoph Fritz (2):
> >   MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
> >   PCI: imx6: add initial imx6sx support
> >
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
> >  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
> >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
> >  3 files changed, 101 insertions(+), 40 deletions(-)
> >
> 
> 
[Zhu hongxing] Hi Christoph:
I'm okay with this patch-set. Hope the regulator handing patch mandatory required by imx6sx pcie
is merged in PM system asap. :).
Thanks.
Richard
