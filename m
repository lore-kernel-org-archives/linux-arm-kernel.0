From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 Sep 2014 12:35:32 +0100
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
In-Reply-To: <20140917180524.GG18532@arm.com>
References: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
 <20140917170338.GC18532@arm.com>
 <CAL_JsqKTZyPgbxy=pPmFPKRxa97oaWqC6u6pBvqvja_URLno4Q@mail.gmail.com>
 <20140917180524.GG18532@arm.com>
Message-ID: <541AC384.8010806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Catalin/Will/Rob,

On 17/09/14 19:05, Will Deacon wrote:
> On Wed, Sep 17, 2014 at 06:47:19PM +0100, Rob Herring wrote:
>> On Wed, Sep 17, 2014 at 12:03 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Wed, Sep 17, 2014 at 12:56:07PM +0100, Robin Murphy wrote:
>>>> Commit 591c1e ("of: configure the platform device dma parameters)
>>>> introduced a common mechanism to configure DMA from DT properties.
>>>> AMBA devices created from DT can take advantage of this, too.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>>    Acked-by: Will Deacon <will.deacon@arm.com>
>>>
>>> It would be great if the arm-soc guys can pick this up.
>>
>> Is this a dependency for something else? If so,
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Yeah, it's going to be needed by my IOMMU init rework so that AMBA devices
> get registered with their IOMMUs.
>

Noob question: Does that mean I should resend (with ACKs) to 
arm at kernel.org? (I wasn't entirely sure where this should go, hence just 
throwing at the list with CCs)

Robin.

> Will
>
