From: joro@8bytes.org (Joerg Roedel)
Date: Sun, 18 Mar 2012 14:27:46 +0100
Subject: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
In-Reply-To: <4F63A6F6.9050506@samsung.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com>
 <20120315111227.GA2384@amd.com> <4F61FF1D.5000502@samsung.com>
 <4F630841.2070307@linaro.org> <4F63A6F6.9050506@samsung.com>
Message-ID: <20120318132746.GL26973@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 01:47:50PM -0700, Kukjin Kim wrote:
> Anyway Joerg, how do you want to handle this? Do you want to pick up  
> 1/2/3 all of them in your tree? If so, 2nd patch should be on top of  
> some samsung topic stuff.

Since patch 2 only applies to the Samsung tree, it is best to carry
this in your tree for merging. Feel free to add my Acked-by to patch 3.
But any further patches for the Exynos IOMMU drivers should go through
my tree after it is merged.


Thanks,

	Joerg
