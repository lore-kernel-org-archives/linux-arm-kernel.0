From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Mon, 16 Mar 2015 05:07:49 +0000
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <55019423.3080506@codeaurora.org>
Message-ID: <D12BCE95.15953%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/12/15, 08:26, "Timur Tabi" <timur@codeaurora.org> wrote:

>Hanjun Guo wrote:
>> This patch set already tested on multi platforms:
>>   - AMD Seattle board;
>>   - Cavium Thunder board;
>>   - Huawei D02 board;
>>   - Qualcomm ARM64 platform
>>
>> This version 10 patch set address some minor comments and collect ACKs
>>and
>> Reviewed-bys for v9:
>>
>>   - new Acks from Rafael, Olof, Grant, Lorenzo
>>   - new way to handle typdef phys_cpuid_t which suggested by Rafael,
>>     but no functional change
>>   - Remove if(!phys) for early ioremappings
>>   - Rework sleep function for ARM64
>>   - Introduce linux/acpi_irq.h to hold acpi_irq_init()
>>   - Disable ACPI if not HW_REDUCED_ACPI compliant
>>   - Remove the doc of why ACPI on ARM
>
>v10 retested and working as before, so ...
>
>	Tested-by: Timur Tabi <timur@codeaurora.org>
>
>for the whole patchset.


Also retested on AMD Seattle.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

>
>-- 
>Sent by an employee of the Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the
>Code Aurora Forum, hosted by The Linux Foundation.
