From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 24 Dec 2010 16:27:06 +0200
Subject: [PATCH] ARM: colibri-pxa300: use correct SD detect pin
In-Reply-To: <AANLkTikSK_+NcvoBxWWyaOOz6u8oLk-jMj9FzKW_mUhC@mail.gmail.com>
References: <1293116462-10189-1-git-send-email-bjorn.forsman@gmail.com>	<201012231715.36442.marek.vasut@gmail.com>	<AANLkTik-ZE-9mvZ7PN1QZx8OJpHcynNz6-0RqcTS=x+y@mail.gmail.com>	<201012232157.03218.marek.vasut@gmail.com>
	<AANLkTikSK_+NcvoBxWWyaOOz6u8oLk-jMj9FzKW_mUhC@mail.gmail.com>
Message-ID: <4D14ADBA.7070709@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/10 00:13, Bj?rn Forsman wrote:
> 2010/12/23 Marek Vasut <marek.vasut@gmail.com>:
>> On Thursday 23 December 2010 17:59:40 Bj?rn Forsman wrote:
>>> Hi Marek,
>>>
>>> 2010/12/23 Marek Vasut <marek.vasut@gmail.com>:
>>>> On Thursday 23 December 2010 16:01:02 Bj?rn Forsman wrote:
>>>>> The use of wrong SD detect pin was introduced by this commit:
>>>>>
>>>>>   ARM: pxa: Push Colibri evalboard MFP into module files
>>>>>
>>>>> This fixes it.
>>>> Ah, one more thing -- CC linux-arm-kernel (done)
>>> I didn't CC linux-arm-kernel because the patch was meant for
>>> Eric Miao's pxa-linux-2.6.git tree (devel branch). I doesn't apply
>>> to mainline.
>>>
>>> As Eric anyways uses 'git rebase' on his tree every -rc cycle
>>> I suggested that he could squash my patch into your original
>>> patch so that we get nice bisectable history.
>> No, no, no ... regarding arm patches, you always CC linux-arm-kernel.
> Ok.
>
> When the patch is not against mainline, where is appropriate
> place to say what tree it applies to? As a reply to the patch thread?

You can write the explanation in the cover letter, or
if it is just a small single patch without the cover letter,
then beneath the "---" line, but before the "diff ...."

-- 
Regards,
Igor.
