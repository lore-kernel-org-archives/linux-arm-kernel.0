From: joro@8bytes.org ('Joerg Roedel')
Date: Thu, 10 Jan 2013 20:12:08 +0100
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <027601cdef61$2df576a0$89e063e0$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
 <027601cdef61$2df576a0$89e063e0$@samsung.com>
Message-ID: <20130110191207.GI25591@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:34:48AM -0800, Kukjin Kim wrote:
> Hmm, I think, just one [7/12] patch does matter so if you could create topic
> branch and apply [7/12] patch firstly before other drivers/ changes would be
> better to me. It's OK on both trees if I just _merge_ the first [7/12]
> commit in the topic branch you provided for exynos-iommu. But you know, you
> don't have to rebase it once I merge it in Samsung tree.
> 
> How about?

Sounds good. Should I take the patch directly from this post? I would
add your Acked-by then and make it the base for the arm/exynos branch.
Once the branch is set-up, as usual it will not be rebased.


	Joerg
