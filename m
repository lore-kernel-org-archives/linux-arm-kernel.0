From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 15 Sep 2018 08:47:13 -0600
Subject: clean up physical merging helpers
In-Reply-To: <20180915070300.GA10555@lst.de>
References: <20180904191431.20102-1-hch@lst.de> <20180915070300.GA10555@lst.de>
Message-ID: <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/15/18 1:03 AM, Christoph Hellwig wrote:
> Jens, any comments?
> 
> On Tue, Sep 04, 2018 at 12:14:18PM -0700, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series moves various helpers related to merging based on physical
>> addresses from the public headers into block/, moves the Xen special
>> case from arch hooks into common code, cleans up the code a bit, and
>> removes not nessecary includes from the block headers.
> ---end quoted text---
> 

It's a good cleanup, I like it. Would prefer if the arm/xen folks could
ack the first bits, and 13/13 should probably just to in differently.

-- 
Jens Axboe
