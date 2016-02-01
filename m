From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 1 Feb 2016 19:48:41 +0800
Subject: [PATCH v6] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <56AF459F.2050808@gmail.com>
References: <1442230072-31593-1-git-send-email-pi-cheng.chen@linaro.org>
 <CAGS+omCkYTPyjMk6QaoxGAL4QVU8VcpWyFqWhST+iP2EFRcRYg@mail.gmail.com>
 <CALx668XVnhhLJWs7RBxvaX=SU=S9=wFVT9HMDP2edqiH4Jio4A@mail.gmail.com>
 <20151217090628.GA317@quark.deferred.io>
 <CAGS+omBWEVac_in-ZDurf4R5tje3hzJPyr5nsP2Z_v7F8sSCUg@mail.gmail.com>
 <56AF459F.2050808@gmail.com>
Message-ID: <CAGS+omDd8KTd1jtmDdzr3t=NGdsY0ND4gepmmyVuh0dD=fJ+VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 7:46 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
> On 26/01/16 11:23, Daniel Kurtz wrote:
>>
>> Hi Michael, Pi-Cheng,
>>
>> On Thu, Dec 17, 2015 at 1:06 AM, Michael Turquette
>> <mturquette@baylibre.com> wrote:
>>>
>>>
>>> On 12/01, Pi-Cheng Chen wrote:
>>>>
>>>> On Mon, Nov 30, 2015 at 11:48 AM, Daniel Kurtz <djkurtz@chromium.org>
>>>> wrote:
>>>>>
>>>>> Hi Pi-Cheng and Michael,
>>>>>
>>>>> On Mon, Sep 14, 2015 at 7:27 PM, Pi-Cheng Chen
>>>>> <pi-cheng.chen@linaro.org> wrote:
>>>>>>
>>>>>> From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
>>>>>>
>>>>>> This patch adds CPU mux clocks which are used by Mediatek cpufreq
>>>>>> driver
>>>>>> for intermediate clock source switching.
>>>>>
>>>>>
>>>>> It looks like this patch was never picked up.
>>>>> It is required for MT8173 cpufreq.
>>>>>
>>>>> What is the plan to get this one merged?
>>>>
>>>>
>>>> Hi Dan,
>>>> Mike is working on a new CCF feature called "coordinated clock rate
>>>> changes"
>>>> which would help to migrate mt8173-cpufreq driver to generic cpufreq-dt
>>>> driver, and I am working with him to port MT8173 clock driver on the new
>>>> feature. So I think that's why this patch was not picked since it will
>>>> be migrated to new implementation once the new feature's ready.
>>>>
>>>> @Mike:
>>>> Are you plannig to post those patches on the mailing list ?
>>>> Or is it fine for you to take this first and then I will refine it for
>>>> the new feature later?
>>>
>>>
>>> I plan to post those patches next week.
>>
>>
>> Were these patches ever posted?
>> Or should we consider going ahead and trying to merge this 4-month old
>> MTK CPU mux clock patch into v4.5 before it is too late?
>>
>
> It's already too late for v4.5. The -rc are mostly bug fixes and new
> features get merged after the official v4.5 release. They will show up in
> v4.6-rc1

Which will show up in v4.6-rc1?  MediaTek's CPU mux clocks, or Mike's
"coordinated clock rate changes"?
