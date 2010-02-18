From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 18 Feb 2010 21:01:46 +0900
Subject: PL-330 DMA driver
In-Reply-To: <e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
Message-ID: <4B7D2C2A.8030802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/18/2010 3:24 PM, Dan Williams wrote:
> On Tue, Feb 16, 2010 at 10:50 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
>> Hello,
>>
>> ?any Samsung SoCs have PL-330 as the DMA controller and the driver
>> is missing in the mainline.
>>
>> A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
>> based on the DMA API(drivers/dma/), but the patches weren't accepted.
> 
> Looking back at the archives seems I missed this patch.  So it was not
> rejected just overlooked.  Do we want to move forward on that patch as
> it stands, or go a different direction?  If it is resubmitted I will
> get it in the queue for 2.6.34.
> 

You can find the prior patch of pl330 from the below url.
http://patchwork.kernel.org/patch/47847/

If needs, i can resubmit patch based from async_tx repo after some test.
