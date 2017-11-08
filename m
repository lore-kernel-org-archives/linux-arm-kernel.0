From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 8 Nov 2017 15:42:39 +0000
Subject: [PATCH v4 20/20] cpufreq: scmi: add support for fast frequency
 switching
In-Reply-To: <CAK8P3a03wGUQ+wMsRctuqhN20iBrgLTZOnFqN1k3gCXnwaBtDA@mail.gmail.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-21-git-send-email-sudeep.holla@arm.com>
 <4588325.776kYim3Ci@aspire.rjw.lan>
 <3f79f75f-1b6a-3f7b-b0c0-f970f0fb6c12@arm.com>
 <CAK8P3a03wGUQ+wMsRctuqhN20iBrgLTZOnFqN1k3gCXnwaBtDA@mail.gmail.com>
Message-ID: <555fa0d1-6499-3d40-29c3-0c3148a6bff0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/17 11:05, Arnd Bergmann wrote:
> On Wed, Nov 8, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 08/11/17 00:24, Rafael J. Wysocki wrote:
>>> On Friday, November 3, 2017 3:47:57 PM CET Sudeep Holla wrote:
>>>> The cpufreq core provides option for drivers to implement fast_switch
>>>> callback which is invoked for frequency switching from interrupt context.
>>>>
>>>> This patch adds support for fast_switch callback in SCMI cpufreq driver
>>>> by making use of polling based SCMI transfer. It also sets the flag
>>>> fast_switch_possible.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>>> Cc: linux-pm at vger.kernel.org
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> I'm assuming that this material will go in along with the rest of the series
>>> through a different tree.
>>>
>>
>> Indeed, I will ask ARM-SoC guys to take it via their tree when ready. I
>> assume you are fine with that, please provide ack if that's still the case.
> 
> Yes, that makes sense.
> 


Thanks Arnd. Thanks Rafael for the ack.

-- 
Regards,
Sudeep
