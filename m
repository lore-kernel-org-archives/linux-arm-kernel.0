From: srinidhikasagar@gmail.com (Srinidhi Kasagar)
Date: Wed, 10 Nov 2010 13:17:43 +0530
Subject: [PATCH] ARM: Common GIC entry macro code
In-Reply-To: <AANLkTikOkqzagFRTQRysEKw1JhZ9a1tMm1fMOoiMC9q4@mail.gmail.com>
References: <20101110070043.18735.53764.sendpatchset@t400s>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D4FAF4A@dbde02.ent.ti.com>
	<AANLkTikOkqzagFRTQRysEKw1JhZ9a1tMm1fMOoiMC9q4@mail.gmail.com>
Message-ID: <AANLkTimjCB265Nv+wHZ8C2s+s--gi5Azgu1-uQNiDbAi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 1:05 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Nov 10, 2010 at 4:16 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>>> Subject: [PATCH] ARM: Common GIC entry macro code
>>>
>> I guess this was attempted by below patch as well.
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6284%2F1
>>
>> 6284/1 in the RMKs patch system. This was also addressing OMAP and the
>> patch was tested OK.
>
> Thanks for the pointer! Looks almost identical to what I just hacked
> up. The main difference seems to be that the implementation in the
> tracker depends on "gic_cpu_base_addr" which isn't used by all
> sub-architectures.
>
>> Looks like it needs to be rebased because the state I see in the patch
>> System is
>>
>> - - Note 2 submitted by Russell King on 02 Sep 2010 15:43:12 (UTC) - - -
>> Moved to Discarded.
>>
>> Doesn't apply:
>
> Ironically enough it looks like it was the omap2 bits that didn't
> apply properly.
>
> If I don't hear anything then I'll just resend my patch to the
> tracker. If the other implementation gets merged sooner then that's
> even better - having some code to share is much better than
> duplicating the same code again and again.

If you rebase to the discarded one in tracker, I would be happy.

Anyway Acked-by: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>

Srinidhi
