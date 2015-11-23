From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 22 Nov 2015 21:31:35 -0500
Subject: [PATCH V6 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <CAHp75VdAdrbQv1EY+KDsoAbyGURxfr+3c5f=-w=OR4MhBoWDHA@mail.gmail.com>
References: <1448210257-4768-1-git-send-email-okaya@codeaurora.org>
 <1448210257-4768-3-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc72HLbNdPKXzm=RqsFZS1cmAVuH3Nd6yO+TJidLeuExg@mail.gmail.com>
 <565bdce834ba1cf4a73029b5c027856e.squirrel@www.codeaurora.org>
 <CAHp75VdAdrbQv1EY+KDsoAbyGURxfr+3c5f=-w=OR4MhBoWDHA@mail.gmail.com>
Message-ID: <56527A87.80201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>
>>> Can it be like
>>>
>>> /sys/?/DEVICExx/
>>>  channelYY/
>>>  attr1
>>>  attr2
>>>  ?
>>>
>>> ?
>>
>> I'll work on it. I didn't know that you are allowed to create subdirectories
>> in sysfs. I was just creating attributes to keep it simple. But, your
>> suggestion is cleaner.
>>
>>>
>>> I think it will be easier to handle in code and from user. (Similar
>>> way DMAEngine API does for slave DMA devices)
>>
>> Now, the good stuff. Can you clarify your comment? I didn't understand it.
> 
> I meant that DMAEngine uses
> /sys/class/dma
>  dmaYchannelX/
>   attr1
>   attr2
>   ?
> 
> layout.
> 

I have posted v7 with this change.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
