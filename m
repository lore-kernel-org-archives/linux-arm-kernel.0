From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 17 Feb 2010 18:45:23 +0900
Subject: PL-330 DMA driver
In-Reply-To: <4B7B95C8.5070400@samsung.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<4B7B95C8.5070400@samsung.com>
Message-ID: <1b68c6791002170145qdad96f1hbd1cba3de24b6cb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 4:07 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> On 2/17/2010 2:50 PM, jassi brar wrote:
>> Hello,
>>
>> ? Many Samsung SoCs have PL-330 as the DMA controller and the driver
>> is missing in the mainline.
>>
>> A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
>> based on the DMA API(drivers/dma/), but the patches weren't accepted.
>> Perhaps the driver should go into arch/arm/common/ ? Or inconspicuously
>> into arch/arm/plat-s3cxxxx/ ?
> First we need a decision about we use which dma api. I think it's better
> we use the DMA API, but i agree about using s3c dma api for
> compatibility of the existing s3c dma api too.
Also, PL330 is 'configurable' (one implementation can be
different from the other) that too adds one reason for it to be in
plat-samsung
Still, I would like maintainers to suggest.
