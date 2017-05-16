From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Tue, 16 May 2017 10:15:28 +0000
Subject: [RFC v1 3/7] iommu/arm-smmu-v3: Replace the device tree binding
 for hisilicon broken prefetch cmd with erratum id
In-Reply-To: <CAL_JsqLH7iT7O2U3g6J26YGBUmt53PDymLJ5VCLByW_97L_M4w@mail.gmail.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
 <CAL_JsqLH7iT7O2U3g6J26YGBUmt53PDymLJ5VCLByW_97L_M4w@mail.gmail.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838350804@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Monday, May 15, 2017 4:24 PM
> To: Shameerali Kolothum Thodi
> Cc: Will Deacon; Robin Murphy; Mark Rutland; Lorenzo Pieralisi; Hanjun Guo;
> Gabriele Paoloni; John Garry; Linux IOMMU; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> devel at acpica.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [RFC v1 3/7] iommu/arm-smmu-v3: Replace the device tree
> binding for hisilicon broken prefetch cmd with erratum id
> 
> On Sat, May 13, 2017 at 4:47 AM, shameer
> <shameerali.kolothum.thodi@huawei.com> wrote:
> > Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > index be57550..bf48e92 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > @@ -46,7 +46,7 @@ the PCIe specification.
> >                          devicetree/bindings/interrupt-controller/msi.txt
> >                        for a description of the msi-parent property.
> >
> > -- hisilicon,broken-prefetch-cmd
> > +- hisilicon,erratum-161010701
> 
> Why? Your missing commit msg should answer that. This breaks
> compatibility, so you are stuck with the old string.
> 
> I'd prefer that you start using the compatible string rather than every vendor
> adding a property for every errata.

Ok. I will wait for the review of other patches in this series and update it accordingly
in the next revision.

Thanks,
Shameer
