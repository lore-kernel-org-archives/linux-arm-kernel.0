From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 16:00:11 -0700
Subject: [GIT PULL] ARM/ARM64 architected timer updates for v3.12
In-Reply-To: <521FCC0A.80302@linaro.org>
References: <521F8157.20203@arm.com>
	<521FCC0A.80302@linaro.org>
Message-ID: <CAOesGMi6egj=PUKGVU4kA6GDsQj-9fDi4+NiTa0gBzENDuNXcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 3:32 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 08/29/2013 07:13 PM, Sudeep KarkadaNagesha wrote:
>> Hi Daniel,
>>
>> These are the ARM/ARM64 arch timer updates for v3.12.
>> I have re-based the changes on tip/timers/core as there are conflicts
>> with memory mapped arch_timers support queued recently.
>> Since this series adds CPU PM notifiers for arch_timers, it is required
>> to enable ARM bL cpuidle drivers(already queued for v3.12)
>>
>> Regards,
>> Sudeep
>>
>> The following changes since commit cfb6d656d569510ac9239583ce09e4c92ad54719:
>>
>>   Merge branch 'timers/clockevents-next' of
>> git://git.linaro.org/people/dlezcano/clockevents into timers/core
>> (2013-08-21 14:59:23 +0200)
>>
>> are available in the git repository at:
>>
>>
>>   git://linux-arm.org/linux-skn.git timer_evtstrm
>>
>> for you to fetch changes up to f74f198e540c160b1db9470b679dbeb72339829b:
>>
>>   drivers: clocksource: add CPU PM notifier for ARM architected timer
>> (2013-08-29 17:43:08 +0100)
>
>
> Hi Sudeep,
>
> I need the acked-by from Olof or Kevin for the arch/arm[64] changes.

For 3.12? Too late. Ping me after the mere window for a 3.13 ack instead.


Thanks,

-Olof
