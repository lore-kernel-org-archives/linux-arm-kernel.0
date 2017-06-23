From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Fri, 23 Jun 2017 12:49:34 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 CMD_PREFETCH quirk(erratum 161010701)
In-Reply-To: <20170623120207.GA2310@arm.com>
References: <20170517091205.7752-1-shameerali.kolothum.thodi@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA838388F08@FRAEML521-MBS.china.huawei.com>
 <20170623120207.GA2310@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83838930B@FRAEML521-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, June 23, 2017 1:02 PM
> To: Shameerali Kolothum Thodi
> Cc: robin.murphy at arm.com; mark.rutland at arm.com;
> lorenzo.pieralisi at arm.com; John Garry; Gabriele Paoloni; Guohanjun
> (Hanjun Guo); xuwei (O); Linuxarm; devel at acpica.org; linux-
> acpi at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> CMD_PREFETCH quirk(erratum 161010701)
> 
> On Fri, Jun 23, 2017 at 08:29:28AM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > Sent: Wednesday, May 17, 2017 10:12 AM
> > > To: robin.murphy at arm.com; will.deacon at arm.com;
> mark.rutland at arm.com;
> > > lorenzo.pieralisi at arm.com
> > > Cc: John Garry; Gabriele Paoloni; Guohanjun (Hanjun Guo); xuwei (O);
> > > Linuxarm; devel at acpica.org; linux-acpi at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org; devicetree at vger.kernel.org; Shameerali
> > > Kolothum Thodi
> > > Subject: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> > > CMD_PREFETCH quirk(erratum 161010701)
> > >
> > > HiSilicon SMMUv3 on Hip06/Hip07 platforms doesn't support
> > > CMD_PREFETCH command. The dt based support for this quirk is already
> > > present in the driver(hisilicon,broken-prefetch-cmd). This adds ACPI
> > > support for the quirk using the IORT smmu model number.
> >
> > This also  has dependency on acpica header update and it looks like
> > it's going to take a while to appear on Linux mainline. I have seen
> > patches where a temp local definition for SMMU v3 model number is
> suggested instead.
> >
> > Could you please let me know the plan so that I can base this patch
> > similar to or on top of Caviums "[PATCH] iommu/arm-smmu-v3, acpi: Add
> > temporary Cavium SMMU-V3 IORT model number definitions"
> 
> I think I've got this in hand, but I'll shout if I run into any issues.

Ok. Thanks Will. Sure.

Shameer
