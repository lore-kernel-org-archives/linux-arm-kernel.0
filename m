From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 01 Aug 2013 22:14:03 +0900
Subject: [PATCH v8 07/12] iommu/exynos: support for device tree
In-Reply-To: <1743111.Ek7FldnHal@flatron>
References: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
 <1743111.Ek7FldnHal@flatron>
Message-ID: <003a01ce8eb8$fe946db0$fbbd4910$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tomasz Figa [mailto:tomasz.figa at gmail.com]
> Sent: Saturday, July 27, 2013 11:07 PM
> 
> Hi,
> 
> On Friday 26 of July 2013 20:28:36 Cho KyongHo wrote:
> > This commit adds device tree support for System MMU.
> > This also include the following changes and enhancements:
> >
> > * use managed device helper functions.
> > Simplyfies System MMU device driver.
> >
> > * use only a single clock descriptor.
> > System MMU device descriptor is seperate if it is imposible to make
> > a single clock descriptor to make a device descriptor for a group of
> > System MMUs.
> >
> > * removed dbgname member from sysmmu_drvdata structure.
> > debugging kernel message for a System MMU is distinguisheable with the
> > name of device descroptors.
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  drivers/iommu/Kconfig        |    5 +-
> >  drivers/iommu/exynos-iommu.c |  182
> > ++++++++++++++++-------------------------- 2 files changed, 70
> > insertions(+), 117 deletions(-)
> 
> Whenever you introduce or modify (extend) a device tree binding please
> don't forget about reflecting that in documentation
> (Documentation/devicetree/bindings) and CCing devicetree mailing list
> (devicetree at vger.kernel.org). Both of these steps are necessary to get any
> device tree stuff merged.
> 

Oh I see.
Thank you for advice.

> Best regards,
> Tomasz
