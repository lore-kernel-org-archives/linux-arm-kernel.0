From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 7 Oct 2011 13:37:01 +0200
Subject: [PATCH v2 5/5] iommu/exynos: Use bus_set_iommu instead of
	register_iommu
In-Reply-To: <CAHQjnOPiAOA_RiHnF-aVEYnWcdkwNzVD1BTNua+-ztZrW_+6_A@mail.gmail.com>
References: <017001cc7f43$04a2db60$0de89220$%kim@samsung.com>
	<20110930134643.GS2138@amd.com>
	<CAHQjnOPiAOA_RiHnF-aVEYnWcdkwNzVD1BTNua+-ztZrW_+6_A@mail.gmail.com>
Message-ID: <20111007113701.GC1512@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 08:52:45AM +0900, KyongHo Cho wrote:
> On Fri, Sep 30, 2011 at 10:46 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> > On Fri, Sep 30, 2011 at 03:31:49AM -0400, Kukjin Kim wrote:
> >> From: KyongHo Cho <pullip.cho@samsung.com>
> >>
> >> This replaces register_iommu() with bus_set_iommu() according to the
> >> suggestion of Joerg Roedel.
> >
> > This should be part of patch 3 already when the bus_set_iommu() change
> > is merged. Otherwise it breaks bisectability too.
> >
> Ok.
> Should I include fault handling feature (patch 4) in the patch 3 also?

Yes, makes sense to include patch 4 too.
