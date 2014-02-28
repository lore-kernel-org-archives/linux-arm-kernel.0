From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 28 Feb 2014 07:26:03 +0100
Subject: [PATCH v4 0/4] ARM: zynq: cpufreq support
In-Reply-To: <20140227175217.GW13293@xsjandreislx>
References: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140227175217.GW13293@xsjandreislx>
Message-ID: <2aebf1c5-f0d6-41a9-b6f7-c709ceecc9a1@AM1EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 06:52 PM, S?ren Brinkmann wrote:
> Hi Daniel, Michal,
> 
> On Wed, 2014-02-19 at 03:14PM -0800, Soren Brinkmann wrote:
>> Hi,
>>
>> another iteration of this series. The patches are the same as in v3, but
>> the series shrank a bit. I rebased this series on tip/timers/core, hence
>> the two patches for the clockevent core fell out, since Thomas already
>> applied those.
>> Additionally I removed the patch 'clocksource/cadence_ttc: Use only one
>> counter'. Thomas brought up some questions regarding that patch which
>> need to be investigated. Since it is not required for the rest of this
>> series, I just dropped it for now.
>>
>> 	Thanks,
>> 	S?ren
>>
>> Soren Brinkmann (4):
>>   clocksource/cadence_ttc: Call clockevents_update_freq() with IRQs
>>     enabled
>>   clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
>>   arm: zynq: Don't use arm_global_timer with cpufreq
>>   arm: zynq: Add support for cpufreq
> 
> Any comments? I think most of these should be pretty straight forward
> and it would be nice to get some ACKs - or tell me what's wrong. :)
> 'clocksource/cadence_ttc: Overhaul clocksource frequency adjustment'
> might deserve a more thorough review.

No problem from my side.
Daniel?

Thanks,
Michal
