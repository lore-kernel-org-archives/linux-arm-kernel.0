From: joro@8bytes.org ('Joerg Roedel')
Date: Thu, 10 Jan 2013 19:38:23 +0100
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <026e01cdef5d$364fd150$a2ef73f0$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
 <026e01cdef5d$364fd150$a2ef73f0$@samsung.com>
Message-ID: <20130110183823.GH25591@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:06:24AM -0800, Kukjin Kim wrote:
> You know, we have several options to avoid it. When you take this series in
> your tree, you can provide topic branch for me. Or this series should be
> separated for arch/arm/ and drivers/ for both trees, then only drivers/iommu
> changes should be picked up in your tree. I'm OK both, let me know which one
> you would prefer or other way.

I would like to take the final version of this patch-set (when you
provided your Acked-by) into the arm/exynos branch in my tree. You can
then pull in this branch to the Samsung tree and we can the conflicts
this way.


	Joerg
