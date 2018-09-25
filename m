From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Sep 2018 11:48:17 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Fix race handling in
 split_blk_unmap()
In-Reply-To: <20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
 <20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
Message-ID: <e86cd69f-4355-5078-890a-338756e325ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 25/09/18 10:01, Joerg Roedel wrote:
> Hey Robin,
> 
> On Thu, Aug 23, 2018 at 01:14:59PM +0100, Robin Murphy wrote:
>> Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> I can't find a newer version of this in my inbox, do you plan to send
> one or has it been addressed differently?

Will has the cleaned-up version in his tree along with a couple of other 
SMMU fixes, which I assume he's planning to send you a pull for (he's 
off at yet another conference just now so I can't confirm offline). We 
were planning for the non-strict stuff to come in as SMMU updates on top 
of that (p.s. please shout if you have any objections on that series so 
I can get on them ASAP!)

Thanks,
Robin.
