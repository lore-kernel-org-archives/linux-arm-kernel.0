From: skannan@codeaurora.org (skannan at codeaurora.org)
Date: Fri, 11 Jul 2014 10:07:24 -0000
Subject: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
 <CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
 <2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
Message-ID: <de0adfb19532c754298579dbba62a6b9.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


skannan at codeaurora.org wrote:
>
> Viresh Kumar wrote:
>> Hi Saravana,
>>
>> Thanks for trying this..
>>
>> On 11 July 2014 09:48, Saravana Kannan <skannan@codeaurora.org> wrote:
>>> The CPUfreq driver moves the cpufreq policy ownership between CPUs when
>>
>> s/driver/core
>
> Will do
>

<snip>

Soooo many typos. This is what happens when I send a late night email! If
a sentence sounds incomplete, this is why.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
