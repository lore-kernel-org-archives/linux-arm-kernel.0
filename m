From: j-keerthy@ti.com (Keerthy)
Date: Wed, 4 Jul 2018 10:11:42 +0530
Subject: [PATCH RESEND 1/2] ti: wkup_m3_ipc: Add rtc_only with ddr in self
 refresh mode support
In-Reply-To: <8d347d42-371f-4e75-d781-aa67d093e1a3@oracle.com>
References: <1529572954-22244-1-git-send-email-j-keerthy@ti.com>
 <f83093e3-b681-f33f-8d2e-42cabee03b7f@ti.com>
 <8d347d42-371f-4e75-d781-aa67d093e1a3@oracle.com>
Message-ID: <e11a6f66-5210-2cfe-f4de-ddf5bd267617@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 04 July 2018 10:07 AM, santosh.shilimkar at oracle.com wrote:
> On 7/3/18 9:23 PM, Keerthy wrote:
>>
>>
>> On Thursday 21 June 2018 02:52 PM, Keerthy wrote:
>>> Adds rtc_only support. This needs resume function to shutdown and
>>> reboot the m3.
>>
>> A gentle ping on this series.
>>
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>
>>> This is tested on am437x-gp-evm and target for 4.19
> 
> Am I suppose to pick up this series 

./scripts/get_maintainer.pl
wkm3/0001-ti-wkup_m3_ipc-Add-rtc_only-with-ddr-in-self-refresh.patch

Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)
linux-kernel at vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR
DRIVERS)
linux-arm-kernel at lists.infradead.org (moderated list:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)

./scripts/get_maintainer.pl
wkm3/0002-soc-ti-wkup_m3_ipc-Add-wkup_m3_request_wake_src.patch

Santosh Shilimkar <ssantosh@kernel.org> (maintainer:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)
linux-kernel at vger.kernel.org (open list:TI KEYSTONE MULTICORE NAVIGATOR
DRIVERS)
linux-arm-kernel at lists.infradead.org (moderated list:TI KEYSTONE
MULTICORE NAVIGATOR DRIVERS)

For some reason both patches points you as the Maintainer :-P.

Regards,
Keerthy
