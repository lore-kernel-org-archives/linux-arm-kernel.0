From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 1 May 2012 12:25:24 +0300
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <4F9F9BC1.9020908@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
 <4F9F9BC1.9020908@linaro.org>
Message-ID: <CAP245DV+uJt3Ke7TbHvtTe2=e8JvckZiyyYY5p0xW6T-oLs3Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 11:16 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>
>> Daniel Lezcano<daniel.lezcano@linaro.org> ?writes:
>>
>>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>>>
>>>> This patchset makes some cleanup on these cpuidle drivers
>>>> and consolidate the code across both architecture.
>>>>
>>>> Tested on OMAP3 (igepV2).
>>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.
>>
>>
>> Without offlining CPU1, none of this code is executed. ?Can you test
>> with CPU1 offlined?
>
>
> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
> Rob tested the series but when he unplugged the cpu1, the kernel panics for
> another reason. I guess the problem should have been fixed since the last
> testing.
>
> Rob ? Do you mind the test the series again, the problem you were facing
> when unplugging the cpu1 may have been fixed.

I'd rather have someone from the OMAP community that understands the
internals test this - adding Santosh to see if he can bring some
engineering time to bear on this series.

> Mike ? if you have time, is it possible you test it on your board ?

And Mike and Rajendra, if you could help with this, it would be great.
We'd really like to get various platform cpuidle driver changes in for
3.5 so that Daniel can take a stab at more consolidation for the core
in the next cycle.

/Amit
