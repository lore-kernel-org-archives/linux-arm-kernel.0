From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 04 Nov 2013 15:36:42 +0800
Subject: [PATCH] arm/arm64: remove atomic_clear_mask() in
 "include/asm/atomic.h"
In-Reply-To: <794E70F6-80D3-4100-A0FF-A6F34AFB9A59@arm.com>
References: <5256117A.4000009@asianux.com> <5256121A.9030504@asianux.com>
 <52561269.60900@asianux.com>
 <20131010100733.GH3817@mudshark.cambridge.arm.com>
 <52568998.2080108@asianux.com>
 <20131010142305.GG6199@mudshark.cambridge.arm.com>
 <525751E2.3020207@asianux.com>
 <20131011104419.GE14732@mudshark.cambridge.arm.com>
 <5257E033.3090607@asianux.com> <5257E539.9080902@asianux.com>
 <20131011165530.GS14732@mudshark.cambridge.arm.com>
 <794E70F6-80D3-4100-A0FF-A6F34AFB9A59@arm.com>
Message-ID: <52774E8A.2080901@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maintainers:

Are these related patches for "arm[64]/include/asm/atomic.h" OK? If also
need me do something, please let me know, and I will/should try.

Thanks.


On 10/13/2013 06:28 AM, Catalin Marinas wrote:
> On 11 Oct 2013, at 17:55, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Oct 11, 2013 at 12:47:05PM +0100, Chen Gang wrote:
>>> In current kernel wide source code, except other architectures, only
>>> s390 scsi drivers use atomic_clear_mask(), and arm/arm64 need not
>>> support s390 drivers.
>>>
>>> So remove atomic_clear_mask() from "arm[64]/include/asm/atomic.h".
>>
>>  Acked-by: Will Deacon <will.deacon@arm.com>
>>
>> Catalin, are you happy for me to send this via the ARM tree?
> 
> Fine by me.
> 
> Catalin
> 
> 


-- 
Chen Gang
