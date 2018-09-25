From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 11:01:38 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Fix race handling in
 split_blk_unmap()
In-Reply-To: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
Message-ID: <20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Robin,

On Thu, Aug 23, 2018 at 01:14:59PM +0100, Robin Murphy wrote:
> Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I can't find a newer version of this in my inbox, do you plan to send
one or has it been addressed differently?


Regards,

	Joerg
