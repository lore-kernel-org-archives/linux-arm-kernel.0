From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 23 Jan 2013 16:39:28 +0530
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex
 A9
In-Reply-To: <20130123.125851.1450151123804323961.hdoyu@nvidia.com>
References: <50FEC503.2080602@wwwdotorg.org><CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com><50FFA620.50008@ti.com>
 <20130123.125851.1450151123804323961.hdoyu@nvidia.com>
Message-ID: <50FFC4E8.70509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 January 2013 04:28 PM, Hiroshi Doyu wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote @ Wed, 23 Jan 2013 09:58:08 +0100:
>
>> On Tuesday 22 January 2013 10:34 PM, Olof Johansson wrote:
>>> On Tue, Jan 22, 2013 at 8:57 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 01/21/2013 11:07 PM, Santosh Shilimkar wrote:
>>>>> On Tuesday 22 January 2013 11:22 AM, Hiroshi Doyu wrote:
>>>>>> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.

[..]

>> Btw, I noticed the build error with patch 1/1. Since I wasn't using
>> the first interface in OMAP code, I just bypassed it for testing.
>> I might be missing some dependent patch which added
>> read_cpuid_part_number().
>
> The following one, which is in "next-20130123", is also necessary.
>
> commit 59530adc3f1b802c275f0197fc3ac72dc014267a
> Author: Christoffer Dall <c.dall@virtualopensystems.com>
> Date:   Tue Dec 18 04:06:37 2012 +0000
>
>      ARM: Define CPU part numbers and implementors
>
Thanks for the pointer Hiroshi.

Regards,
Santosh
