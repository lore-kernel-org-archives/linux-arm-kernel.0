From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 25 Nov 2014 13:57:49 -0800
Subject: [PATCH v14 0/7] KVM/arm/x86: dirty page logging for ARMv7
 (3.17.0-rc1)
In-Reply-To: <20141125102207.GB31297@cbox>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <20141125102207.GB31297@cbox>
Message-ID: <5474FB5D.8050008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 02:22 AM, Christoffer Dall wrote:
> Hi Mario,
> 
> On Thu, Nov 13, 2014 at 05:57:41PM -0800, Mario Smarduch wrote:
>> Patch series adds support for ARMv7 and generic dirty page logging support. 
>> As we try to move towards generic dirty page logging additional logic is moved 
>> to generic code. Initially x86, armv7 KVM_GET_DIRTY_LOG reuses generic 
>> code, shortly followed by armv8 patches.
>>
> So given the timing of this and the last-minute fixes to this series, it
> is too late to merge for 3.19.
> 
> I would like if we could get one complete patch series with both v7 and
> v8 support in there ready for right after the merge window closes, so
> that Marc and I can queue this early for -next and then merge it for
> 3.20.
> 
> Thanks,
> -Christoffer
> 
Hi Christoffer,
   got it.

Thanks.
