From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 09 Aug 2016 09:21:05 +0530
Subject: [PATCH v6 00/11] qcom: Add support for TSENS driver
In-Reply-To: <1469696120.2367.107.camel@intel.com>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
 <575A57F8.6060004@codeaurora.org> <576391B3.7090508@codeaurora.org>
 <57749F20.4010700@codeaurora.org> <1469694828.2367.102.camel@intel.com>
 <1469696120.2367.107.camel@intel.com>
Message-ID: <57A95329.9080804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[]..

>>>>>>
>>>>>> Current set of patches apply on 4.6-rc6. Fixes for the nvmem
>>>>>> apis
>>>>>> are now posted [1] and queued in -next [2]
>>>>>> Patches [1-6] will need to be merged via thermal
>>>>>> tree/Eduardo.
>>>>> Any plans to pull these in for 4.8?
>>>> These patches have been on the list for quite a while, and they
>>>> do not have any outstanding dependencies or comments to be
>>>> addressed. I would really hope to see these in for 4.8.
>>>> Let me know if there is something you want me to address before
>>>> you pull them in.
>>> Would you be able to pull this driver in? I haven't heard back
>>> anything from Eduardo despite multiple pings.
>>> These patches (v6) have been on the list for a couple months now,
>>> which address all issues/concerns that were raised by Eduardo
>>> in his previous reviews.
>>>
>> Sorry for my late response as I took medical leave earlier this month
>> for a noise surgery and I'm just back to work.
>>
>> I synced with Eduardo yesterday, he was also really busy recently,
>> but
>> he will go through the pending patches soon.
>> So, for this patch set, I still prefer to let Eduardo to take it if
>> he
>> has time, and I will take them if you still don't get feedback from
>> Eduardo after the merge window, does this sound okay for you?
>>
> Hah, it seems that Eduardo has already took your patches, sorry for the
> noise. :)

Hey Rui, yes, thanks, I was out the last couple weeks too so could not
respond.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
