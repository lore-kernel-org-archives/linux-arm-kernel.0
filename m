From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 11 Apr 2018 13:10:41 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
 <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
Message-ID: <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/2018 5:43 PM, Sinan Kaya wrote:
> On 4/6/2018 5:26 PM, James Hogan wrote:
>> On Fri, Apr 06, 2018 at 02:15:57PM -0400, Sinan Kaya wrote:
>>> On 4/5/2018 9:34 PM, Sinan Kaya wrote:
>>>> Can we get these merged to 4.17? 
>>>>
>>>> There was a consensus to fix the architectures having API violation issues.
>>>> https://www.mail-archive.com/netdev at vger.kernel.org/msg225971.html
>>>>
>>>>
>>>
>>> Any news on the MIPS front? Is this something that Arnd can merge? or does it have
>>> to go through the MIPS tree.
>>
>> It needs some MIPS input really. I'll try and take a look soon. Thanks
>> for the nudge.
>>
>>> It feels like the MIPS is dead since nobody replied to me in the last few weeks on
>>> a very important topic.
>>
>> Not dead, just both maintainers heavily distracted by real life right
>> now (which sadly, for me at least, trumps this very important topic) and
>> doing the best they can given the circumstances.
> 
> Thanks for the reply. Glad to hear somebody cares.


How is the likelihood of getting this fixed on 4.17 kernel? There was an agreement
to fix all architectures. MIPS is the only one left.

> 
>>
>> Cheers
>> James
>>
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
