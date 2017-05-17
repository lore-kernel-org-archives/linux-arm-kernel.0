From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 17 May 2017 10:47:30 +0530
Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
In-Reply-To: <20170516140943.ps2yufiukz6iurpl@latitude>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
 <20170516140943.ps2yufiukz6iurpl@latitude>
Message-ID: <f5f8de4a-73a1-a32f-2736-2a7e64bfaa1a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 5/16/2017 7:39 PM, Jonathan Neusch?fer wrote:
> Hi, I have a few suggestions on how to make this commit message more
> readable:
> 
> On Tue, May 16, 2017 at 10:54:13AM +0530, Sricharan R wrote:
>> While returning EPROBE_DEFER for iommu masters
> 
> Add a comma at the end of this line
> 
>> take in to account of iommu nodes that could be
> 
> s/in to/into/
> s/of iommu/of_iommu/
> 

ok, will correct the above.

Regards,
 Sricharan

>> marked in DT as 'status=disabled', in which case
>> simply return NULL and let the master's probe
>> continue rather than deferring.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Tested-by: Will Deacon <will.deacon@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> 
> Thanks,
> Jonathan Neusch?fer
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
