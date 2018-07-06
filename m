From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Fri, 6 Jul 2018 11:18:55 +0000
Subject: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
In-Reply-To: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180706111327.7gkerhkk6udfeirr@8bytes.org>
Message-ID: <HE1PR0401MB24256CD990DAE3A343EF3A8AE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Joro,

I will be sending it by mid of next week.

Regards,
Nipun

> -----Original Message-----
> From: joro at 8bytes.org [mailto:joro at 8bytes.org]
> Sent: Friday, July 6, 2018 4:43 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy at arm.com; will.deacon at arm.com;
> gregkh at linuxfoundation.org; hch at lst.de; m.szyprowski at samsung.com;
> shawnguo at kernel.org; frowand.list at gmail.com; iommu at lists.linux-
> foundation.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; linux-
> pci at vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder at gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
> 
> Hi Nipun,
> 
> On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> > Will this patch-set be taken for the next kernel release (and via which tree)?
> 
> I can take this through IOMMU tree if nobody objects. Please work out
> the last remaining comment on patch 7 with Robin and then re-send with
> all Acks and Reviewed-by: tags included.
> 
> Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
> that sheme for the other patches/prefixes as well.
> 
> Thanks,
> 
> 	Joerg
