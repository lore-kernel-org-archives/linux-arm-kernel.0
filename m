From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 17 Aug 2012 15:42:07 +0530
Subject: [PATCH v2 09/31] arm64: Cache maintenance routines
In-Reply-To: <20120817100729.GF24389@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-10-git-send-email-catalin.marinas@arm.com>
 <502E1580.70702@ti.com> <20120817100729.GF24389@arm.com>
Message-ID: <CAMQu2gz1A5VCTFS_7vzBhnaLhbEKUOhpH-KfFbrE6YhaLDDxXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 3:37 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Aug 17, 2012 at 10:57:20AM +0100, Santosh Shilimkar wrote:
>> On Tuesday 14 August 2012 11:22 PM, Catalin Marinas wrote:
>> > +ENTRY(__cpuc_flush_dcache_all)
>>
>> We have discussed the need of cache maintenance by
>> level kind of API for ARMv7 (A15).
>>
>> Shouldn't we add such API for arm64 as well ?
>
> Yes, at some point we'll probably add but we'll discuss it again when
> actually needed. I wouldn't define new API now that's not used by any
> AArch64 code.
>
The patches are already on the list for ARMv7 and just waiting to merge
two approaches.
I agree once it is getting merged for ARMv7 and ARMv8 port can be
updated.

Regards
Santosh
