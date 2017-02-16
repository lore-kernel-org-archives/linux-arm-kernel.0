From: agraf@suse.de (Alexander Graf)
Date: Thu, 16 Feb 2017 10:32:50 +0100
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <20170216091454.GA2160@mai>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <e2780793-a8ac-4d75-b095-a534e36f8bf7@suse.de> <20170216091454.GA2160@mai>
Message-ID: <48bb19c9-d1f3-a5c1-ec82-4b19d45f88fd@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/02/2017 10:14, Daniel Lezcano wrote:
> On Thu, Feb 16, 2017 at 09:42:11AM +0100, Alexander Graf wrote:
>
> [ ... ]
>
>>>>> I believe Marc is looking at some rework in this area which may enable
>>>>> this, so please wait for that to appear.
>>>> Yeah, I'm implementing a semi-flexible way to add new quirk types, and
>>>> the last thing I want to see is two (or more) tables describing the same
>>>> thing.
>>>
>>> Kindly ping, if you have patches in hand, I can test against our platforms,
>>> thank you very much.
>>
>> Any progress on this? I'm not a big fan of stalling erratum fixes upstream
>> because of potential future refactoring.
>
> The fix is in the tip tree, soon in v4.11-rc1 when the merge will be finished.
>
> http://goo.gl/x90qwE
> http://goo.gl/asCBBD

Oh, I missed that. Sorry for the fuss :).


Alex
