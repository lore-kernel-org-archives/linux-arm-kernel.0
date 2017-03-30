From: majun258@huawei.com (majun (Euler7))
Date: Thu, 30 Mar 2017 12:08:39 +0800
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <58DC7674.8020301@linaro.org>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170329101400.GA10807@red-moon> <58DBA010.1020002@linaro.org>
 <20170329123821.GA10988@red-moon> <58DBAFD6.7070300@linaro.org>
 <d620f35e-f335-bab5-49e0-a92375e00ea5@arm.com>
 <20170329161354.GC11297@red-moon> <20170329173243.GA6091@red-moon>
 <58DC7674.8020301@linaro.org>
Message-ID: <58DC84C7.5050608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all:

? 2017/3/30 11:07, Hanjun Guo ??:
> On 03/30/2017 01:32 AM, Lorenzo Pieralisi wrote:
>> On Wed, Mar 29, 2017 at 05:13:54PM +0100, Lorenzo Pieralisi wrote:
>>> On Wed, Mar 29, 2017 at 03:52:47PM +0100, Marc Zyngier wrote:
>>>> On 29/03/17 14:00, Hanjun Guo wrote:
>>>>> On 03/29/2017 08:38 PM, Lorenzo Pieralisi wrote:
>>>>>> On Wed, Mar 29, 2017 at 07:52:48PM +0800, Hanjun Guo wrote:
>>>>>>> Hi Lorenzo,
>>>>>>>
>>>>>>> On 03/29/2017 06:14 PM, Lorenzo Pieralisi wrote:
>>>>>>>> Hi Hanjun, Marc,
>>>>>>>>
>>>>>>>> On Tue, Mar 07, 2017 at 08:40:05PM +0800, Hanjun Guo wrote:
> [...]
>>>>>>>>>    drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>>>>>>>>>    drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
[...]
>>>>
>>>> Thoughts?
>>>
>>> Perfect for me. Hanjun, I can cherry pick Marc's patch above, rework
>>> this patch and post the resulting branch for everyone to have a final
>>> test.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/arm64-acpi-4.12
>>
>> Please have a look and let me know if that's ok, I planned to send
>> a PR to Catalin by the end of the week (first 7 patches up to
>> 7fc3061df075 ("ACPI: platform: setup MSI domain for ACPI based platform
>> device")).
> 
> Perfect for me too, Lorenzo, Marc, Thank you very much.
> 
> I'm currently in paternity leave and can't reach the machine,
> I had a detail review with the patches, they looks good to me,
> Ma Jun and Wei Xu will test on Hisilicon machines and give the
> feedback.

The sas/xge/uart are working fine on my hisilicon board with
Lorenzo's branch (arm64-acpi-4.12)

Thanks
Majun

> 
> Thanks
> Hanjun
> 
> .
> 
