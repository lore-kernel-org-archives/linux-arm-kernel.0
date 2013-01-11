From: joro@8bytes.org ('Joerg Roedel')
Date: Fri, 11 Jan 2013 16:52:26 +0100
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <02ae01cdef69$67d66200$37832600$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
 <027601cdef61$2df576a0$89e063e0$@samsung.com>
 <20130110191207.GI25591@8bytes.org>
 <02ae01cdef69$67d66200$37832600$@samsung.com>
Message-ID: <20130111155226.GK25591@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Thu, Jan 10, 2013 at 11:33:41AM -0800, Kukjin Kim wrote:
> Sure, keep going on with
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Done that. Applied the patch, some manual work was necessary as the
patch didn't apply cleanly to v3.8-rc3. Please double-check if the
result is correct.

> OK, good. Let me know the name of branch when you set-up it :-)

I pushed the branch to

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git arm/exynos

>From there you can pull it into your tree.

Have fun,

     Joerg
