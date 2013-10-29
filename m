From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Oct 2013 04:32:41 +0000
Subject: [PATCH v2] ARM: SMMU: add devices attached to the SMMU to an
 IOMMU group
In-Reply-To: <1382978662.4097.35.camel@ul30vt.home>
References: <1382108910-18049-1-git-send-email-a.motakis@virtualopensystems.com>
 <1382978662.4097.35.camel@ul30vt.home>
Message-ID: <20131029043240.GE22291@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 04:44:22PM +0000, Alex Williamson wrote:
> On Fri, 2013-10-18 at 17:08 +0200, Antonios Motakis wrote:
> > IOMMU groups are expected by certain users of the IOMMU API,
> > e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
> > group to satisfy those users.
> > 
> > Changes from v1:
> >  * Added check that dev->archdata.iommu has not been set already by an IOMMU
> >    driver. This way we can also skip checking for an existing IOMMU group.
> > 
> > Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> 
> 
> Looks ok to me.
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Yup, looks fine to me too. I'm travelling until next week, so I'll start
picking things up then.

Cheers,

Will
