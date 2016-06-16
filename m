From: po.liu@nxp.com (Po Liu)
Date: Thu, 16 Jun 2016 10:50:23 +0000
Subject: [PATCH v3 1/2] nxp/dts: add pcie aer interrupt-name property in
 the dts
In-Reply-To: <20160616003627.GJ20243@tiger>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
 <20160616003627.GJ20243@tiger>
Message-ID: <VI1PR0401MB1709B98EC43F035158CF022E92560@VI1PR0401MB1709.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

>  -----Original Message-----
>  From: Shawn Guo [mailto:shawnguo at kernel.org]
>  Sent: Thursday, June 16, 2016 8:36 AM
>  To: Po Liu
>  Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>  linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Roy Zang; Arnd
>  Bergmann; Marc Zyngier; Stuart Yoder; Yang-Leo Li; Minghuan Lian; Murali
>  Karicheri; Bjorn Helgaas; Mingkai Hu
>  Subject: Re: [PATCH v3 1/2] nxp/dts: add pcie aer interrupt-name
>  property in the dts
>  
>  On Tue, Jun 14, 2016 at 04:24:04PM +0800, Po Liu wrote:
>  > NXP some platforms aer interrupt was not MSI/MSI-X/INTx but using
>  > interrupt line independently. This patch add a "aer"
>  > interrupt-names for aer interrupt.
>  >
>  > Signed-off-by: Po Liu <po.liu@nxp.com>
>  > ---
>  > changes for v3:
>  > 	- None;
>  >
>  >  .../devicetree/bindings/pci/layerscape-pci.txt         |  4 ++--
>  
>  The bindings shouldn't be part of dts patch but the driver patch who is
>  actually using it.
>  
>  Shawn

Ok, I'll move the doc part to the driver patch.

Po Liu
>From NXP
>  
>  >  arch/arm/boot/dts/ls1021a.dtsi                         |  6 ++++--
>  >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 18
>  +++++++++---------
>  >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi         | 16 ++++++++-
>  -------
>  >  4 files changed, 23 insertions(+), 21 deletions(-)
