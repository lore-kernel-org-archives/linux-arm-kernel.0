From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Thu, 13 Sep 2018 05:01:46 +0000
Subject: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
In-Reply-To: <20180912165845.GD16071@arm.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
 <20180912165845.GD16071@arm.com>
Message-ID: <VI1PR04MB448065E40C0930BA42FDE08DE61A0@VI1PR04MB4480.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Wednesday, September 12, 2018 10:29 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: joro at 8bytes.org; robin.murphy at arm.com; robh+dt at kernel.org;
> robh at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> gregkh at linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas at google.com; hch at lst.de; m.szyprowski at samsung.com;
> shawnguo at kernel.org; frowand.list at gmail.com; iommu at lists.linux-
> foundation.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; linux-
> pci at vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder at gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
> 
> Hi Nipun,
> 
> On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> > This patchset defines IOMMU DT binding for fsl-mc bus and adds
> > support in SMMU for fsl-mc bus.
> >
> > These patches
> >   - Define property 'iommu-map' for fsl-mc bus (patch 1)
> >   - Integrates the fsl-mc bus with the SMMU using this
> >     IOMMU binding (patch 2,3,4)
> >   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
> >   - Updates the fsl-mc device node with iommu/dma related changes (patch 7)
> 
> It looks like you have all the Acks in place for this series now, so I
> assume it's going to go via Joerg directly. Is that right?

This is what I am expecting :)
 
> Will
> 
