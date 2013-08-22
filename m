From: zonque@gmail.com (Daniel Mack)
Date: Thu, 22 Aug 2013 08:07:36 +0200
Subject: remove pxa ssp driver???
In-Reply-To: <CADApbehAcOKsPdrVo_CrkFfqFtB+wy1xr00m-fMbVgbaJkr4ug@mail.gmail.com>
References: <CADApbej4bvSW7PVXnor4v3iFMcZ=ZHN9T_ST5-SYFJZM9sakDQ@mail.gmail.com>
 <521481A7.5030504@gmail.com>
 <CADApbehAcOKsPdrVo_CrkFfqFtB+wy1xr00m-fMbVgbaJkr4ug@mail.gmail.com>
Message-ID: <5215AAA8.5050001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.08.2013 05:13, Chao Xie wrote:
> On Wed, Aug 21, 2013 at 5:00 PM, Daniel Mack <zonque@gmail.com> wrote:

>> Yes, I agree, but I'd like to schedule that for after the 3.12 merge
>> window has settled. Is that ok for you?
>>
> That is fine.
> You have submited the patches for removing the old pxa DMA driver, what is the
> status for that?

No, not yet. The patch to do this is part of a big series that needs a
lot more testing. Unfortunately, I haven't got much feedback yet from
people who use PXA platforms. If you could give it a try, please do:

  https://github.com/zonque/linux/tree/pxa-dma-v2

Some parts of this series have been extracted and merged, but only such
patches that don't break the current DMA implementation.


Thanks,
Daniel
