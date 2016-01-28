From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 28 Jan 2016 11:34:09 +0000
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page
 size
In-Reply-To: <CAKv+Gu_v4x8U=2enO03QPLacYZG5Gk1HE8kBy8Qf2boeNtKbRw@mail.gmail.com>
References: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
 <20160128103441.GS14823@e104818-lin.cambridge.arm.com>
 <20160128110820.GE30928@arm.com> <56A9FB15.1080203@arm.com>
 <CAKv+Gu_v4x8U=2enO03QPLacYZG5Gk1HE8kBy8Qf2boeNtKbRw@mail.gmail.com>
Message-ID: <56A9FCB1.5040802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 11:30, Ard Biesheuvel wrote:
> On 28 January 2016 at 12:27, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 28/01/16 11:08, Will Deacon wrote:

>>> I thought there was also a suggestion that we could fail gracefully in
>>> the EFI stub if we detected an unsupported page size?
>>
>>
>> Yes, there was. But then it was also recommended [1] to add a new stubbed
>> function
>> for both arm & arm64, where it got lost. May be we should revive it.
>>
>> https://lkml.org/lkml/2015/10/15/489
>>
>
> I can pick this up
>

Thanks Ard.


Cheers
Suzuki
