From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 6 Mar 2015 12:26:20 +0800
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150305185701.GH4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <20150305185701.GH4932@quad.lixom.net>
Message-ID: <54F92C6C.4040203@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/6 2:57, Olof Johansson wrote:
> Hi,

Hi Olof,

>
> On Wed, Feb 25, 2015 at 04:39:40PM +0800, Hanjun Guo wrote:
>> Changes since v8:
>>   - remove MPIDR packing things by introducing phys_cpuid_t;
>>
>>   - update patch acpi: fix acpi_os_ioremap for arm64 to follow
>>     Rafael's suggestion;
>>
>>   - Squash patch (disable ACPI if ACPI less than 5.1) to patch
>>     (Get RSDP and ACPI boot-time table);
>>
>>   - Move sleep_arm.c to arch/arm64/ and rename it as acpi_sleep.c 
>>
>>   - Rework the uefi generated empty dtb to enable acpi when no dtb
>>     is available, thanks Ard for the updated patch.
>>
>>   - rework the function of register cpu for kexec case
>>
>>   - use pr_debug() instead of pr_info() when scanning MADT.
>>
>>   - rebase on top of 4.0-rc1
>>
> I've looked at most of the arch code besides GIC and some of the timer stuff,
> which I might revisit later, but the pieces I've seen seem reasonable. I've
> acked individual patches.

Thank you very much for the ACKs and review comments!

>
> There are some cleanups to be made, but that can be done incrementally on top,
> it's all internal implementation details.

Definitely in my TODO list :)

>
> I also haven't looked closely at the documentation patches yet, so I might have
> some comments on those showing up.

OK, thanks.

Regards
Hanjun
