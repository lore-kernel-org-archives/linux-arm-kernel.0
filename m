From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 21 Jul 2015 20:49:14 +0530
Subject: [PATCH 4/5] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <20150721151314.GM3061@x1>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437070618-21330-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150716213429.GE1602@sirena.org.uk> <55A895AC.8070101@linaro.org>
 <20150717111733.GL11162@sirena.org.uk> <55A8F859.2090204@linaro.org>
 <20150720073011.GA3061@x1> <55ACE2FC.2090801@linaro.org>
 <20150721092148.GI3061@x1> <55AE29DF.10102@linaro.org>
 <20150721151314.GM3061@x1>
Message-ID: <55AE62F2.4050403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 July 2015 08:43 PM, Lee Jones wrote:
> On Tue, 21 Jul 2015, Vaibhav Hiremath wrote:
>
>>
>>
>> On Tuesday 21 July 2015 02:51 PM, Lee Jones wrote:
>>> On Mon, 20 Jul 2015, Vaibhav Hiremath wrote:
>>>
>>>>
>>>>
>>>> On Monday 20 July 2015 01:00 PM, Lee Jones wrote:
>>>>> On Fri, 17 Jul 2015, Vaibhav Hiremath wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On Friday 17 July 2015 04:47 PM, Mark Brown wrote:
>>>>>>> On Fri, Jul 17, 2015 at 11:12:04AM +0530, Vaibhav Hiremath wrote:
>>>>>>>
>>>>>>>> Can you merge this into regulator tree?
>>>>>>>
>>>>>>>> Link to MFD - https://lkml.org/lkml/2015/7/16/704
>>>>>>>
>>>>>>> I need a tag I can pull from Lee.
>>>>>>>
>>>>>> Great.
>>>>>>
>>>>>> Lee,
>>>>>> It would be helpful, if you could ack below patch,
>>>>>>
>>>>>> https://lkml.org/lkml/2015/7/16/704
>>>>>
>>>>> These patches are yet to be reviewed.  I will unmark those patches as
>>>>> important (meaning they will not be reviewed during this iteration).
>>>>> Please resubmit a single patch-set containing all of the
>>>>> dependencies and Mark and I will work it out between us.
>>>>>
>>>>
>>>> Ok,
>>>>
>>>> I have just sent single patch, which has dependency on regulator
>>>> changes. Please review, ack and queue up.
>>>
>>> A little presumptuous, don't you think? ;)
>>>
>>>> [PATCH-v3] mfd: 88pm80x: Add 88pm860 chip type support
>>>> https://patchwork.kernel.org/patch/6826531/
>>>
>>> So nothing depends on this anymore, right?
>>>
>>
>> No, regulato patch depends on this.
>> Mark needs your tag in order to take above patch through regulator tree.
>
> That's not how we usually do things.
>
> However, as this patch is a very simple one, it shouldn't cause too
> many issues if it were to go in via the Regulator tree.
>

Thanks for your ack.

And I understand your concern, but not sure how would you solve such
dependency?

Another point which keeps bugging me is, git-bisect.

Thanks,
Vaibhav

>> Just to clarify more,
>>
>> I have regulator patch which adds support for 88PM860
>> https://lkml.org/lkml/2015/7/16/719
>>
>> which depends on above patch
>> https://patchwork.kernel.org/patch/6826531/
>>
>> Thanks,
>> Vaibhav
>>
>
