From: yang.shi@linaro.org (Shi, Yang)
Date: Mon, 09 Nov 2015 10:16:32 -0800
Subject: [PATCH V2 0/2] arm64: cleanup FRAME_POINTER kconfig option and
 force to select it
In-Reply-To: <20151109181422.GE21606@e104818-lin.cambridge.arm.com>
References: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
 <20151109181422.GE21606@e104818-lin.cambridge.arm.com>
Message-ID: <5640E300.2000001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2015 10:14 AM, Catalin Marinas wrote:
> On Mon, Nov 09, 2015 at 09:43:55AM -0800, Yang Shi wrote:
>> According to the discussion on the mailing list, this version adds a new patch
>> to force select FRAME_POINTER for ARM64.
>>
>> Change v2 --> v1:
>> 1. Adds a new patch to force select FRAME_POINTER
>> 2. Notes that this change adds a dependency on DEBUG_KERNEL for building with
>> frame pointers
>>
>>
>> Yang Shi (2):
>>        arm64: remove redundant FRAME_POINTER kconfig option
>>        arm64: force to select FRAME_POINTER
>
> Do you really need two patches for this?

I just thought it may be clearer in this way. If nobody thinks it is 
necessary, I definitely could merge them into one.

Thanks,
Yang

>
