From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Feb 2017 10:49:10 +0100
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <58A574D9.10300@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <e2780793-a8ac-4d75-b095-a534e36f8bf7@suse.de> <20170216091454.GA2160@mai>
 <48bb19c9-d1f3-a5c1-ec82-4b19d45f88fd@suse.de>
 <ee8f0a16-8ed4-8300-74af-cdb404516ae2@huawei.com> <58A574D9.10300@huawei.com>
Message-ID: <8cc0c3eb-c279-5cb1-4d6f-1a6419e0874e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/2017 10:46, Sanil Kumar wrote:
> On 2/16/2017 3:11 PM, Ding Tianhong wrote:
>>
>> On 2017/2/16 17:32, Alexander Graf wrote:
>>>
>>> On 16/02/2017 10:14, Daniel Lezcano wrote:
>>>> On Thu, Feb 16, 2017 at 09:42:11AM +0100, Alexander Graf wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>>> I believe Marc is looking at some rework in this area which may
>>>>>>>> enable
>>>>>>>> this, so please wait for that to appear.
>>>>>>> Yeah, I'm implementing a semi-flexible way to add new quirk
>>>>>>> types, and
>>>>>>> the last thing I want to see is two (or more) tables describing
>>>>>>> the same
>>>>>>> thing.
>>>>>> Kindly ping, if you have patches in hand, I can test against our
>>>>>> platforms,
>>>>>> thank you very much.
>>>>> Any progress on this? I'm not a big fan of stalling erratum fixes
>>>>> upstream
>>>>> because of potential future refactoring.
>>>> The fix is in the tip tree, soon in v4.11-rc1 when the merge will be
>>>> finished.
>>>>
>>>> http://goo.gl/x90qwE
>>>> http://goo.gl/asCBBD
>>> Oh, I missed that. Sorry for the fuss :).
>>>
>>>
>>> Alex
>>>
>> Hi, I thinks the tip tree is only applied the erratum for DT, not for
>> ACPI, the patch
>> for ACPI is not applied yet, so the work isn't finished. ??
> Yes, initial thread was about ACPI part. I think Alex was asking about
> that.

Ah yes. Indeed.

Thanks.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
