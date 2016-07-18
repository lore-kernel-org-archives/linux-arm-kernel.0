From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 18 Jul 2016 15:30:17 +0300
Subject: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
In-Reply-To: <20160718122125.GJ5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160718103137.GG5783@n2100.arm.linux.org.uk>
 <5c538963-ae46-54fc-27bf-dbae81443215@ti.com>
 <20160718122125.GJ5783@n2100.arm.linux.org.uk>
Message-ID: <2c542d87-3fd6-62db-1e37-159b673f6dc2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/16 15:21, Russell King - ARM Linux wrote:
> On Mon, Jul 18, 2016 at 03:07:57PM +0300, Peter Ujfalusi wrote:
>> I was not aware of any position on this from TI - as I mentioned I was not
>> involved with DMA. It could be that the position from 'TI' is still what it
>> was. Or changed. But as I have been asked to look after TI DMA drivers
>> upstream and I believe that the linked list mode is a good thing to have -
>> which is backed by my experiences. My position is that linked list support is
>> cool.
> 
> That's really nice news.  Nothing like asking the author first whether
> he'd like to pass over maintainership of the driver.  I guess you won't
> mind if at some point in the future, I decide to just take it back...

I work with the DMA drivers on behalf of TI. Inside TI the DMA related queries
are targeted at me. This does not change the maintainer of the drivers upstream.

-- 
P?ter
