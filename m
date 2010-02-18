From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 18 Feb 2010 15:36:00 +0900
Subject: PL-330 DMA driver
In-Reply-To: <e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
Message-ID: <1b68c6791002172236y12e0909bv940be3f6e5ebc813@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 3:24 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Feb 16, 2010 at 10:50 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
>> Hello,
>>
>> ?Many Samsung SoCs have PL-330 as the DMA controller and the driver
>> is missing in the mainline.
>>
>> A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
>> based on the DMA API(drivers/dma/), but the patches weren't accepted.
>
> Looking back at the archives seems I missed this patch. ?So it was not
> rejected just overlooked. ?Do we want to move forward on that patch as
> it stands, or go a different direction? ?If it is resubmitted I will
> get it in the queue for 2.6.34.
Great, but you might want to wait for the platform maintainer's (Ben Dooks)
opinion as it is going to have impact on extant dma client drivers of the
platform which so far shared one dma API across various SOCs.
