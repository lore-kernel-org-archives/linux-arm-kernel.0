From: nleeder@codeaurora.org (Neil Leeder)
Date: Mon, 23 May 2016 14:12:50 -0400
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <57433810.6000400@codeaurora.org>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
 <573F7F5C.1050100@codeaurora.org>
 <4ad1d1b2-f0eb-3780-21e7-9dd1b23d6934@codeaurora.org>
 <57433810.6000400@codeaurora.org>
Message-ID: <5738cfe3-4299-703f-52c9-24f6e6a58adc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/23/2016 01:04 PM, Stephen Boyd wrote:
> On 05/23/2016 08:43 AM, Neil Leeder wrote:
>>
>> On 5/20/2016 05:19 PM, Stephen Boyd wrote:
>>
>>>
>>> Is there a patch to add sysreg.h to arch/arm? It would be nice to use
>>> one l2 accessor API on arm64 and arm.
>>>
>> Sounds like a good thing for the next person who submits a krait L2 patch to consider.
>>
> 
> Heh, ok. If it isn't supported in this patch then we need to make the
> config depend on ARM64 so that this doesn't fail to compile on ARM.
> 

Ok, I'll add that in v2 too.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
