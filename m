From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 18 May 2015 19:04:30 +0200
Subject: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <5559D66A.5070406@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
 <20150505145538.GL15736@8bytes.org> <5559D66A.5070406@samsung.com>
Message-ID: <20150518170430.GK20611@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, May 18, 2015 at 02:09:14PM +0200, Marek Szyprowski wrote:
> >Hmm, will this remove support for iommu-groups in the exynos driver? I
> >am still working on the default-domain patch-set which makes iommu-group
> >support mandatory for iommu-drivers.
> 
> I you wish, I can leave this code. iommu-groups were not used at all
> on Exynos,
> so I thought that there is no point keeping useless code.

Yes, please keep the iommu-goups support, it will be required at some
point.


	Joerg
