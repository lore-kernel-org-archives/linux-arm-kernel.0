From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 14 Mar 2016 09:53:09 -0400
Subject: [PATCH V14 5/9] dma: qcom_hidma: implement lower level hardware
 interface
In-Reply-To: <20160313160034.GE13211@localhost>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-6-git-send-email-okaya@codeaurora.org>
 <20160311020650.GG11154@localhost> <56E2EC1C.6040107@codeaurora.org>
 <20160311163221.GC13211@localhost> <56E2F5EA.10207@codeaurora.org>
 <56E31CA5.6040106@codeaurora.org> <56E33FBB.2000401@codeaurora.org>
 <20160313160034.GE13211@localhost>
Message-ID: <56E6C245.3090702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2016 12:00 PM, Vinod Koul wrote:
> On Fri, Mar 11, 2016 at 04:59:23PM -0500, Sinan Kaya wrote:
>> Vinod,
>>
>> On 3/11/2016 2:29 PM, Sinan Kaya wrote:
>>> I have done the renaming. This is all left for me to post a follow up.
>>
>> I just posted v15 (forgot to put v15 on 4/4).
> 
> Don't do that manually!
> 
> git formt-patch --subject-prefix is for that
> 

Thanks for the hint. I was using the --annotate option and adding version numbers.

>>
>> http://www.spinics.net/lists/arm-kernel/msg490282.html
>>
>> I wanted to get v15 out before the end of the week with the macro renames. 
>> Let me know which lines need corrections.
>>
>> There is also a single line change for the object hierarchy patch. The code 
>> was looking up DMA attributes (OF:dma-coherent) from the wrong place.
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
