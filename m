From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 12 Mar 2015 08:26:59 -0500
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55019423.3080506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun Guo wrote:
> This patch set already tested on multi platforms:
>   - AMD Seattle board;
>   - Cavium Thunder board;
>   - Huawei D02 board;
>   - Qualcomm ARM64 platform
>
> This version 10 patch set address some minor comments and collect ACKs and
> Reviewed-bys for v9:
>
>   - new Acks from Rafael, Olof, Grant, Lorenzo
>   - new way to handle typdef phys_cpuid_t which suggested by Rafael,
>     but no functional change
>   - Remove if(!phys) for early ioremappings
>   - Rework sleep function for ARM64
>   - Introduce linux/acpi_irq.h to hold acpi_irq_init()
>   - Disable ACPI if not HW_REDUCED_ACPI compliant
>   - Remove the doc of why ACPI on ARM

v10 retested and working as before, so ...

	Tested-by: Timur Tabi <timur@codeaurora.org>

for the whole patchset.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
