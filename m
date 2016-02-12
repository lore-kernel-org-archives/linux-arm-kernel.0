From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2016 17:27:17 +0000
Subject: [PATCH v2] iommu/io-pgtable: Rationalise quirk handling
In-Reply-To: <62860b753f304beef7b4b6f1e13d7094252f2f37.1455294748.git.robin.murphy@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
 <62860b753f304beef7b4b6f1e13d7094252f2f37.1455294748.git.robin.murphy@arm.com>
Message-ID: <20160212172716.GH17901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:09:46PM +0000, Robin Murphy wrote:
> As the number of io-pgtable implementations grows beyond 1, it's time
> to rationalise the quirks mechanism before things have a chance to
> start getting really ugly and out-of-hand.
> 
> To that end:
> - Indicate exactly which quirks each format can/does support.
> - Fail creating a table if a caller wants unsupported quirks.
> - Properly document where each quirk applies and why.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Just to allay any confusion, I intend this as a followup to the
> short-descriptor[1] and Mediatek IOMMU[2] patches, rather than a
> crucial addition, so it can either get picked up along with those
> or wait 'til later.

I'd like to see it included in whichever tree takes the short-descriptor
code so, in case that's not my tree:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
