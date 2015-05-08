From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 8 May 2015 20:44:45 +0300
Subject: [PATCH v5 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
In-Reply-To: <20150508150926.GC15563@atomide.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-4-git-send-email-peter.ujfalusi@ti.com>
 <20150504053851.GY3521@localhost> <554B34F2.5050306@ti.com>
 <20150508034110.GW3521@localhost> <554C6034.4020004@ti.com>
 <20150508090330.GB3521@localhost> <20150508150926.GC15563@atomide.com>
Message-ID: <554CF60D.4000001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 06:09 PM, Tony Lindgren wrote:
> * Vinod Koul <vinod.koul@intel.com> [150508 02:04]:
>> On Fri, May 08, 2015 at 10:05:24AM +0300, Peter Ujfalusi wrote:
>>> On 05/08/2015 06:41 AM, Vinod Koul wrote:
>>>> Now as far as this series is concerned, rest of it looks good so I am
>>>> willing to merge to if you plan to work on defered probe :) I think its a
>>>> fair bargain!
>>>
>>> Deal ;)
>> Wonderful :)
>>
>>>
>>> I'll take care of the OMAP/daVinci drivers for omap-dma and edma.
>> Okay, I had asked for ACK on last patch as its ARM one, or do you want me to
>> go ahead and apply it.. will wait till today
> 
> It's best that I queue the .dts change as a follow-up patch once
> the DMA changes are merged. Otherwise it's almost guaranteed to
> produce merge conflicts with other dts changes.
> 
> Peter, let us know if there's an issue with that. If so, we need
> to set up an immutable branch against v4.1-rc1 with just these
> patches so we can merge it in as needed.

Yes, the DT patches w/o the dmaengine changes will brake dra7, but it is not
true other way around.
The DT patches should be merged only when the dmaengine patches are in.

-- 
P?ter
