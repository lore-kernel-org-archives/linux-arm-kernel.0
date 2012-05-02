From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 2 May 2012 11:50:04 +0530
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <4F9FB8F0.80901@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
 <4F9F9BC1.9020908@linaro.org>
 <CAMQu2gzK=u1kkbv9nzRyO3xbqVhZkf0KP=ceCyNteSituBZPrg@mail.gmail.com>
 <4F9FB8F0.80901@linaro.org>
Message-ID: <CAMQu2gxDV0fW+_38+3siKA+sJv6=PXMBAJs9DSkV8sEdv78EUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 3:50 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/01/2012 11:55 AM, Shilimkar, Santosh wrote:
>>
>> On May 1, 2012 1:46 PM, "Daniel Lezcano"<daniel.lezcano@linaro.org>
>> ?wrote:
>>>
>>> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>>>
>>>> Daniel Lezcano<daniel.lezcano@linaro.org> ? writes:
>>>>
>>>>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>>>>>
>>>>>> This patchset makes some cleanup on these cpuidle drivers
>>>>>> and consolidate the code across both architecture.
>>>>>>
>>>>>> Tested on OMAP3 (igepV2).
>>>>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.
>>>>
>>>>
>>>> Without offlining CPU1, none of this code is executed. ?Can you test
>>>> with CPU1 offlined?
>>>
>>>
>>> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
>>> Rob tested the series but when he unplugged the cpu1, the kernel panics
>>
>> for another reason. I guess the problem should have been fixed since the
>> last testing.
>>>
>>> ?Rob ? Do you mind the test the series again, the problem you were facing
>>
>> when unplugging the cpu1 may have been fixed.
>> Have already tested this series on omap4 with cpu offline as well as with
>> couple idle series on top of it.
>> I haven't finished omap3 testing and hence not reported yet. Omap4
>> continies to work with subject series.
>
>
> Great !
>
> I tested it on omap3 igepv2 board and it works fine too.
>
Finished OMAP3 testing too. have already reviewed the series before.
For entire series,
Reviewed-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
