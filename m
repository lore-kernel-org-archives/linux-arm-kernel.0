From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 03 Aug 2015 11:48:37 +0100
Subject: [PATCH v6 0/8] ARM64: juno: add SCPI mailbox protocol, clock
 and CPUFreq support
In-Reply-To: <20150803101845.GU20890@e106497-lin.cambridge.arm.com>
References: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com>
 <20150803101845.GU20890@e106497-lin.cambridge.arm.com>
Message-ID: <55BF4705.9030300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/08/15 11:18, Liviu Dudau wrote:
> On Fri, Jul 31, 2015 at 06:43:03PM +0100, Sudeep Holla wrote:
>> Hi ARM-SoC guys,
>>
>> It has been on the list for a while and have got all the necessary ACKs.
>> Can you please pull this series for v4.3 ?
>>
>> Regards,
>> Sudeep
>>
>> This patch series adds support for:
>>    1. SCPI(System Control and Power Interface) mailbox protocol driver.
>>       It uses ARM MHU mailbox controller driver on Juno but can work with
>>       any mailbox controllers using standard mailbox APIs
>>    2. Add support for clocks provided by SCP firmware through the SCPI
>>       interface
>>    3. Using the existing arm_big_little cpufreq driver and the newly
>>       added SCPI clock driver, it also adds support for CPU DVFS on
>>       ARM64 JUNO development platforms.
>
> Hi Sudeep,
>
> Is there a branch where I can pull this series from?
>

Yes, you can pull from
git://linux-arm.org/linux-skn.git juno_dvfs

Regards,
Sudeep
