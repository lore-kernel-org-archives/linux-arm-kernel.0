From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Tue, 22 Mar 2011 12:11:13 +0530
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <4D87053A.70701@codeaurora.org>
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>	
	<1299570622.2754.4.camel@localhost>
	<4D766A2F.9080001@codeaurora.org>	
	<4D86F295.8040409@codeaurora.org>
	<1300691551.2761.8.camel@localhost> <4D87053A.70701@codeaurora.org>
Message-ID: <4D884489.1040205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/21/2011 1:28 PM, Murali Nalajala wrote:
> On 3/21/2011 12:42 PM, Artem Bityutskiy wrote:
>> On Mon, 2011-03-21 at 12:09 +0530, Murali Nalajala wrote:
>>> On 3/8/2011 11:11 PM, Murali Nalajala wrote:
>>>> On 3/8/2011 12:50 AM, Artem Bityutskiy wrote:
>>>>> On Tue, 2011-03-08 at 05:38 +0530, Murali Nalajala wrote:
>>>>>> Lets non-standard NAND drivers take advantage of known NAND
>>>>>> chip information.
>>>>>>
>>>>>> The initial development of msm nand driver, driver uses the supported
>>>>>> NAND devices information as a hardcoded table. Remove the existing
>>>>>> hardcoded supported flash device table and read the flash device
>>>>>> information from the flash id table which are part of the mtd
>>>>>> subsystem.
>>>>>
>>>>> Why this initial version should be upstream? Why wouldn't you make it
>>>>> "standard" first?
>>>>>
>>>>
>>>> Currently we are not fully using the MTD nand subsystem. That's the
>>>> intention author has introduced "non-standard" here!!!
>>>>
>>>> Thanks,
>>>> Murali N
>>>>
>>>
>>> Any reviews comments on this change?
>>
>> No, I think you should "sell" your driver better than that. Indeed,
>>
>> Q: "Why this initial version should be upstream? Why wouldn't you make
>> it "standard" first?"
>> A: Currently we are not fully using the MTD nand subsystem. That's the
>> intention author has introduced "non-standard" here!!!
>>
>
> The driver (msm_nand.c) is in align to MTD specification.
> But this commit text is bit misleading, initially the driver
> didn't make use of nand flash devices information from the
> flash id table which are part of the MTD subsystem. Hence
> we have enabled this config option to make use of it.
>
> Thanks,
> Murali N
>

Hi,
Still you have any issues/comments?

Thanks,
Murali N

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
