From: joro@8bytes.org ('Joerg Roedel')
Date: Wed, 14 Aug 2013 15:15:49 +0200
Subject: [PATCH 2/2] iommu/exynos: Follow kernel coding style for
 __sysmmu_enable return type
In-Reply-To: <003101ce89ed$52317330$f6945990$@samsung.com>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
 <1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
 <003101ce89ed$52317330$f6945990$@samsung.com>
Message-ID: <20130814131547.GA5889@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KyongHo,

On Fri, Jul 26, 2013 at 07:46:01PM +0900, Cho KyongHo wrote:
> __sysmmu_enable() must return 1 if it is called with the same page table.
> I have fixed it exynos_iommu_attach_device() to always return zero on success
> in the next patchset which I will post today.
> 
> Thank you.

When you are fine with these patches please put them on-top of your
patch-set when you re-submit. I will take them from there then.


	Joerg
