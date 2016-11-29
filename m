From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 29 Nov 2016 17:05:49 +0100
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <20161116095615.GA25656@red-moon>
References: <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
 <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
 <20161114102654.GA1677@red-moon>
 <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
 <20161114155222.GZ2078@8bytes.org>
 <313844ca-d948-1297-84b2-669f3a7d57d2@arm.com>
 <20161116095615.GA25656@red-moon>
Message-ID: <20161129160549.GH2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:56:15AM +0000, Lorenzo Pieralisi wrote:
> I can easily make the changes Robin suggests above, I need to know
> what to do with this patch it is the last blocking point for this
> series and time is running out I can revert to using dev->bus to
> retrieve iommu_ops (even though I do not think it makes sense given
> what Robin outlines below) but I need to know please, we can't gate
> an entire series for this patch that is just syntactic sugar.

Well, I didn't really object to the approach per-se, I just wanted to
know the rationale behind the need for the iommu-ops pointer. So through
which tree should this series be merged?
I think I can live with the pointer for now, we can later convert it to
an iommu-instance pointer.


	Joerg
