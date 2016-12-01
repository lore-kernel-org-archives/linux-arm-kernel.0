From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 01 Dec 2016 20:39:57 +1100
Subject: [PATCH v3 2/3] powerpc/reloc64: add support for 32-bit CRC
 pseudo-symbols
In-Reply-To: <CAKv+Gu8g=qgOg0Q5J7tFu0uBUFTUXdVQ+84N45oZseG3vTm0Bg@mail.gmail.com>
References: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1477585631-18574-3-git-send-email-ard.biesheuvel@linaro.org>
 <87oa13ssqq.fsf@concordia.ellerman.id.au>
 <CAKv+Gu8g=qgOg0Q5J7tFu0uBUFTUXdVQ+84N45oZseG3vTm0Bg@mail.gmail.com>
Message-ID: <874m2ooumq.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> On 25 November 2016 at 11:29, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>
>> [    7.607687] kvm: disagrees about version of symbol module_layout
>> [    7.846799] virtio: disagrees about version of symbol module_layout
>> [   22.012615] crc32c_vpmsum: disagrees about version of symbol module_layout
>> [   22.012959] libcrc32c: disagrees about version of symbol module_layout
>>
>
> Sigh. I suppose your modversions fixes are queued for v4.10? It's
> probably best to revisit this after the v4.10 merge window closes
> then, just to make sure I'm not aiming for a moving target.

Actually they were merged into 4.9-rc7 ish.

But I'm still seeing the same as above with this series rebased on top
of that, and I'm a bit short on time to debug it ATM.

So during the 4.10 cycle is probably the best we can hope for, sorry.

cheers
