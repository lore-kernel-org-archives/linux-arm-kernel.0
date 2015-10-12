From: axboe@fb.com (Jens Axboe)
Date: Mon, 12 Oct 2015 13:22:36 -0600
Subject: [PATCH v2] nvme: fix 32-bit build warning
In-Reply-To: <5683852.vTfiqtLZLZ@wuerfel>
References: <5851501.PBMrs03XFb@wuerfel> <20151012190339.GA31736@lst.de>
 <561C0599.1090904@fb.com> <5683852.vTfiqtLZLZ@wuerfel>
Message-ID: <561C087C.1010900@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 01:14 PM, Arnd Bergmann wrote:
> On Monday 12 October 2015 13:10:17 Jens Axboe wrote:
>> On 10/12/2015 01:03 PM, Christoph Hellwig wrote:
>>> Looks good,
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Note that we're moved the nvme driver to a new directory in the
>>> block tree, but I can rebase it for you if you want.
>>
>> I man handled it on both branches, so we should be good.
>
> Thanks! I already saw the move, and it caused another build error
> when CONFIG_BLOCK is disabled. Do you have this one?

I do, Keith sent that one in earlier today, it's in the 4.4 branch.

-- 
Jens Axboe
