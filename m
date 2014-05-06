From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 06 May 2014 09:33:42 -0700
Subject: [PATCHv5 2/2] arm: Get rid of meminfo
In-Reply-To: <20140501130849.C093DC409DA@trevor.secretlab.ca>
References: <1396544698-15596-1-git-send-email-lauraa@codeaurora.org>
 <1396544698-15596-3-git-send-email-lauraa@codeaurora.org>
 <20140501130849.C093DC409DA@trevor.secretlab.ca>
Message-ID: <53690EE6.2020909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/1/2014 6:08 AM, Grant Likely wrote:
> On Thu,  3 Apr 2014 10:04:58 -0700, Laura Abbott <lauraa@codeaurora.org> wrote:
>> memblock is now fully integrated into the kernel and is the prefered
>> method for tracking memory. Rather than reinvent the wheel with
>> meminfo, migrate to using memblock directly instead of meminfo as
>> an intermediate.
>>
>> Change-Id: I9d04e636f43bf939e13b4934dc23da0c076811d2
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> 
> Tested-by: Grant Likely <grant.likely@linaro.org>
> 
> Tiny nit-picking comment below, but this patch looks really good.
> What's the state on merging this?
> 

I put this into the patch system as 8025/1 a few weeks ago. I've been
busy/on vacation so I haven't had a chance to follow up since then.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
