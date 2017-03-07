From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 7 Mar 2017 11:24:51 -0600
Subject: [PATCH v2 1/2] ARM: imx: Fix mmdc_pmu_write_accesses event
 definition
In-Reply-To: <CAHrpEqQZYEhXoSmEJ-4d+1exUTqFNVfP2mMBiOS3c4wbAOyfdA@mail.gmail.com>
References: <1487160026-9376-1-git-send-email-andrei-tiberiu.breana@nxp.com>
 <1487160026-9376-2-git-send-email-andrei-tiberiu.breana@nxp.com>
 <CAHrpEqTEq+jQkxGpNtpWRbcB=pw36dAxGOxR-xs8iDYGnhE51A@mail.gmail.com>
 <CAHrpEqQZYEhXoSmEJ-4d+1exUTqFNVfP2mMBiOS3c4wbAOyfdA@mail.gmail.com>
Message-ID: <CAHrpEqQK11yRvkD+PZ2sG_FPohBeUagm8oWeHJHG=0HVerJPnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 9:47 AM, Zhi Li <lznuaa@gmail.com> wrote:
> On Wed, Feb 15, 2017 at 8:28 AM, Zhi Li <lznuaa@gmail.com> wrote:
>> On Wed, Feb 15, 2017 at 6:00 AM,  <andrei-tiberiu.breana@nxp.com> wrote:
>>> From: Tiberiu Breana <andrei-tiberiu.breana@nxp.com>
>>>
>>> Fixed an error in the "write-accesses" event definition.
>>>
>>> Signed-off-by: Tiberiu Breana <andrei-tiberiu.breana@nxp.com>
>>
>> Acked-by: Frank Li <Frank.li@nxp.com>
>
> Shawn:

Shawn:

Ping.

best regards
Frank Li

>
> Ping
>
> best regards
> Frank Li
>
>>
>>> ---
>>>  arch/arm/mach-imx/mmdc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
>>> index c03bf28..89a926f 100644
>>> --- a/arch/arm/mach-imx/mmdc.c
>>> +++ b/arch/arm/mach-imx/mmdc.c
>>> @@ -87,7 +87,7 @@ static DEFINE_IDA(mmdc_ida);
>>>  PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles, "event=0x00")
>>>  PMU_EVENT_ATTR_STRING(busy-cycles, mmdc_pmu_busy_cycles, "event=0x01")
>>>  PMU_EVENT_ATTR_STRING(read-accesses, mmdc_pmu_read_accesses, "event=0x02")
>>> -PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "config=0x03")
>>> +PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "event=0x03")
>>>  PMU_EVENT_ATTR_STRING(read-bytes, mmdc_pmu_read_bytes, "event=0x04")
>>>  PMU_EVENT_ATTR_STRING(read-bytes.unit, mmdc_pmu_read_bytes_unit, "MB");
>>>  PMU_EVENT_ATTR_STRING(read-bytes.scale, mmdc_pmu_read_bytes_scale, "0.000001");
>>> --
>>> 2.7.4
>>>
