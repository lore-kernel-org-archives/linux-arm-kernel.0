From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 9 Feb 2017 09:36:45 -0600
Subject: [PATCH v5 2/4] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <5995162.mH49F4H7nS@aspire.rjw.lan>
References: <20170203172929.23940-1-d-gerlach@ti.com>
 <CAL_Jsq+955fra0P8FFWd4-f2rLyJVMwo-FBRfeqqeO=a8m0NnA@mail.gmail.com>
 <2aba1159-9a48-329f-2a54-8079b32b06e2@ti.com>
 <5995162.mH49F4H7nS@aspire.rjw.lan>
Message-ID: <804ab315-3202-8c6d-3954-97a452892aa8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 06:02 PM, Rafael J. Wysocki wrote:
> On Wednesday, February 08, 2017 08:45:55 AM Dave Gerlach wrote:
>> On 02/08/2017 08:44 AM, Rob Herring wrote:
>>> On Fri, Feb 3, 2017 at 11:29 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>> Add the device tree bindings document for the TI CPUFreq/OPP driver
>>>> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
>>>> binding allows us to provide an opp-supported-hw property for each OPP
>>>> to define when it is available. This driver is responsible for reading
>>>> and parsing registers to determine which OPPs can be selectively enabled
>>>> based on the specific SoC in use by matching against the opp-supported-hw
>>>> data.
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +/*
>>>> + * cpu0 has different OPPs depending on SoC revision and some on revisions
>>>> + * 0x2 and 0x4 have eFuse bits that indicate if they are available or not
>>>> + */
>>>> +cpu0_opp_table: opp_table {
>>>
>>> One step closer, but as I showed last time, use a '-', not '_'.
>>
>> I apologize I thought the comment was only about the 0, completely missed the
>> underscore, you are correct, thanks.
>
> Please send an update of this patch, then.

Yes, sent an update of just this patch in reply to the original patch email, thanks.

Regards,
Dave

>
> Thanks,
> Rafael
>
