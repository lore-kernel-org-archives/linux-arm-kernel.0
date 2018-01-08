From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Jan 2018 11:06:36 +0530
Subject: [PATCH v4 6/7] ARM: davinci: convert to common clock framework
In-Reply-To: <7143f0fb-9bb2-dc66-56d4-aefa66f852a1@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-7-git-send-email-david@lechnology.com>
 <e36250ba-3f76-71d9-206f-475738d19e36@ti.com>
 <f09641b7-a9e9-24d1-ce13-1b627d077ce5@lechnology.com>
 <a1593cb6-f471-022f-e41a-74146053fff8@lechnology.com>
 <8fcd9bf8-249b-7e0b-0e37-70f011ab1b7e@ti.com>
 <7143f0fb-9bb2-dc66-56d4-aefa66f852a1@lechnology.com>
Message-ID: <73a551af-2339-c522-188a-d73a58fd03d1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 January 2018 07:12 AM, David Lechner wrote:
> On 01/05/2018 04:42 AM, Sekhar Nori wrote:
>> On Friday 05 January 2018 08:29 AM, David Lechner wrote:
>>> On 01/04/2018 11:50 AM, David Lechner wrote:
>>>> On 1/4/18 6:39 AM, Sekhar Nori wrote:
>>
>>>>> This is a pretty huge patch again and I hope it can be broken down.
>>>>> Ideally one per SoC converted and then the unused code removal.
>>>>>
>>>>
>>>> Will do.
>>>
>>> Well, I can do this, but I don't think it will compile or run. We can't
>>> have the common clock framework and the legacy davinci clocks enabled at
>>> the same time.
>>
>> I see. Can you at least hive off the code removal into a separate patch
>> for next submission. I will then take a closer look at this.
>>
> 
> I've realized that I can accomplish this if I use some #if 0/#endif blocks
> temporarily if that sounds OK.

I haven't looked at your latest submission, but this wont be acceptable.
Even as a temporary measure.

If the patch cannot be broken down any, thats fine. I just wanted to
explore the possibility to ease review.

Thanks,
Sekhar
