From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Sep 2014 12:47:19 -0500
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
In-Reply-To: <20140917170338.GC18532@arm.com>
References: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
 <20140917170338.GC18532@arm.com>
Message-ID: <CAL_JsqKTZyPgbxy=pPmFPKRxa97oaWqC6u6pBvqvja_URLno4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 12:03 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 17, 2014 at 12:56:07PM +0100, Robin Murphy wrote:
>> Commit 591c1e ("of: configure the platform device dma parameters)
>> introduced a common mechanism to configure DMA from DT properties.
>> AMBA devices created from DT can take advantage of this, too.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> It would be great if the arm-soc guys can pick this up.

Is this a dependency for something else? If so,

Acked-by: Rob Herring <robh@kernel.org>

Rob
