From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Sep 2016 10:20:52 +0100
Subject: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
In-Reply-To: <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
Message-ID: <20160914092051.GB19622@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 10:41:57AM +0200, Auger Eric wrote:
> Hi,

Hi Eric,

> On 12/09/2016 18:13, Robin Murphy wrote:
> > To any more confusing fixups and crazily numbered extra patches, here's
> > a quick v7 with everything rebased into the right order. The significant
> > change this time is to implement iommu_fwspec properly from the start,
> > which ends up being far simpler and more robust than faffing about
> > introducing it somewhere 'less intrusive' to move toward core code later.
> > 
> > New branch in the logical place:
> > 
> > git://linux-arm.org/linux-rm iommu/generic-v7
> 
> For information, as discussed privately with Robin I experience some
> regressions with the former and now deprecated dt description.

Please can you share the DT you're using so we can reproduce this locally?

Will
