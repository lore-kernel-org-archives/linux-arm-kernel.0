From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 02 Aug 2013 10:55:07 +0100
Subject: [PATCH v2 0/3] ARM/ARM64 architected timer updates
In-Reply-To: <51FB8081.6040501@linaro.org>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51FB7CB8.6080103@arm.com> <51FB8081.6040501@linaro.org>
Message-ID: <51FB81FB.3060709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/13 10:48, Daniel Lezcano wrote:
> On 08/02/2013 11:32 AM, Sudeep KarkadaNagesha wrote:
>> Hi Daniel,
>>
>> On 22/07/13 12:21, Sudeep KarkadaNagesha wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> This patch series adds support to configure the rate and enable the event
>>> stream for architected timer. Since the timer control register is reset to
>>> zero on warm boot, CPU PM notifier is added to re-initialse it.
>>>
>> This series is required to support TC2 cpuidle.
>> It will be good if you can review and get this in for v3.12
> 
> So do you want me to take the series through my tree ?
> 
Yes I believe it has to go through your(ARM specific clocksource?) tree,
but currently there's a conflict with another bug fix(that should come
from rmk as -rc fix)
(Commit ab8d46c0 "ARM: 7788/1: elf: fix lpae hwcap feature reporting in
proc/cpuinfo" in rmk -fixes)

Regards,
Sudeep
