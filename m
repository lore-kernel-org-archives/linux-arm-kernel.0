From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 15:03:25 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Fix race handling in
 split_blk_unmap()
In-Reply-To: <e86cd69f-4355-5078-890a-338756e325ba@arm.com>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
 <20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
 <e86cd69f-4355-5078-890a-338756e325ba@arm.com>
Message-ID: <20180925130325.7w6hfqarnms2iozi@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Sep 25, 2018 at 11:48:17AM +0100, Robin Murphy wrote:
> Will has the cleaned-up version in his tree along with a couple of other
> SMMU fixes, which I assume he's planning to send you a pull for (he's off at
> yet another conference just now so I can't confirm offline).

Okay, less work for me, fine.

> We were planning for the non-strict stuff to come in as SMMU updates
> on top of that (p.s. please shout if you have any objections on that
> series so I can get on them ASAP!)

No objections, I have suggested this change for quite some time now.
Cool to see you implmented it :) I also looked at the patches and they
look good to me.


Regards,

	Joerg
