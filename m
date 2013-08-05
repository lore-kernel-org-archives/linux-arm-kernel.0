From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 05 Aug 2013 17:25:03 +0100
Subject: [PATCH v2 0/3] ARM/ARM64 architected timer updates
In-Reply-To: <51FBA21D.5010308@linaro.org>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51FB7CB8.6080103@arm.com> <51FB8081.6040501@linaro.org>
 <51FB81FB.3060709@arm.com> <51FBA21D.5010308@linaro.org>
Message-ID: <51FFD1DF.9000907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 02/08/13 13:12, Daniel Lezcano wrote:
> On 08/02/2013 11:55 AM, Sudeep KarkadaNagesha wrote:
>> On 02/08/13 10:48, Daniel Lezcano wrote:
>>> On 08/02/2013 11:32 AM, Sudeep KarkadaNagesha wrote:
>>>> Hi Daniel,
>>>>
>>>> On 22/07/13 12:21, Sudeep KarkadaNagesha wrote:
>>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>>
>>>>> This patch series adds support to configure the rate and enable the event
>>>>> stream for architected timer. Since the timer control register is reset to
>>>>> zero on warm boot, CPU PM notifier is added to re-initialse it.
>>>>>
>>>> This series is required to support TC2 cpuidle.
>>>> It will be good if you can review and get this in for v3.12
>>>
>>> So do you want me to take the series through my tree ?
>>>
>> Yes I believe it has to go through your(ARM specific clocksource?) tree,
>> but currently there's a conflict with another bug fix(that should come
>> from rmk as -rc fix)
>> (Commit ab8d46c0 "ARM: 7788/1: elf: fix lpae hwcap feature reporting in
>> proc/cpuinfo" in rmk -fixes)
> 
> IMO, you should rebase this patch on top of tips/core, I will apply the
> series and when the rmk fix hits this branch (through tips/urgent), that
> will be up to the maintainer to resolve this conflict.
> 

The fix with which this series was conflicting is already in v3.11-rc4
So can I send pull request based on v3.11-rc4 or if you prefer any
particular tree, can you provide details please ?

Regards,
Sudeep
