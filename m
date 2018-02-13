From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Tue, 13 Feb 2018 09:18:28 +0000
Subject: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
In-Reply-To: <20180129162109.GA25266@arm.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
 <20180129153939.GC24972@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83863FC88@FRAEML521-MBX.china.huawei.com>
 <20180129162109.GA25266@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83864614F@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Monday, January 29, 2018 4:21 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: lorenzo.pieralisi at arm.com; robin.murphy at arm.com;
> marc.zyngier at arm.com; joro at 8bytes.org; John Garry
> <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; iommu at lists.linux-foundation.org;
> linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> devicetree at vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> 161010801 erratum(reserve HW MSI)
> 
> On Mon, Jan 29, 2018 at 04:16:33PM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Will Deacon [mailto:will.deacon at arm.com]
> > > Sent: Monday, January 29, 2018 3:40 PM
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: lorenzo.pieralisi at arm.com; robin.murphy at arm.com;
> > > marc.zyngier at arm.com; joro at 8bytes.org; John Garry
> > > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Guohanjun
> > > (Hanjun Guo) <guohanjun@huawei.com>; iommu at lists.linux-
> foundation.org;
> > > linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> > > devicetree at vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> > > Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> > > 161010801 erratum(reserve HW MSI)
> > > On Thu, Dec 14, 2017 at 04:09:54PM +0000, Shameer Kolothum wrote:
> > > > On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> > > > deviates from the standard implementation and this breaks PCIe MSI
> > > > functionality when SMMU is enabled.
> > > >
[...]

> > > It occurred to me this morning that this series probably isn't queued
> anywhere
> > > because it's not obvious which tree is supposed to take it and I can't see it in
> -
> > > next.
> > >
> > > Is this one for arm64, IOMMU, irqchip or something else? It's probably
> missed
> > > the boat for 4.16 now...
> > >
> >
> > I have been trying to ping you guys on this[1]. My expectation was that it will
> be
> > through IOMMU. Anyway missed the boat now, I will re-spin for 4.17.
> 
> The problem with "ping" emails is that they don't really mean anything. In
> this case, everybody probably assumed somebody else was picking it up so you
> didn't get a reply.
> 
> Joerg may be ok pulling this, but it's odd to have dts changes going via his
> tree. You might want to split those out, at least. Talk to him.

As this series missed out from the PULL request, I am preparing to send this again.
Please let me know, you are ok with the dts changes being part of this or would like
to split it.

Thanks,
Shameer
