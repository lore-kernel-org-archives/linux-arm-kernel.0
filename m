From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 18:28:25 +0100
Subject: [PATCH 1/5] iommu: Allow taking a reference on a group directly
In-Reply-To: <20161109180059.GJ17771@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
 <20161109172543.GI17771@arm.com>
 <8b35afe8-7e09-c2d3-91ae-5d2a10da6fc8@arm.com>
 <20161109180059.GJ17771@arm.com>
Message-ID: <20161110172824.GM2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 06:00:59PM +0000, Will Deacon wrote:
> I'd still rather the new function was renamed. We already have the group,
> so calling a weird underscore version of iommu_group_get is really
> counter-intuitive.
> 
> Joerg -- do you have a preference?

iommu_group_ref_get sound best to me. Unfortunatly C has no function
overloading ;)


	Joerg
