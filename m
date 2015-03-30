From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 30 Mar 2015 11:49:44 -0500
Subject: [patch v11 00/23] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55197EA8.1000807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2015 09:02 AM, Hanjun Guo wrote:
> Some fixes since last version:
>
>   - Add a patch 19/23 for disabling ACPI for Xen on ARM64 for now to fix
>     compile errors on XEN ACPI, Stefano and Julien are ok with this
>     temporary solution.
>   - Add patch "ARM64 / ACPI: Don't unflatten device tree if acpi=force
>     is passed", which will fix the problem that the device tree will
>     be unflattened even if acpi=force passed, that will not obey the
>     policy.
>   - update patch "irqchip: Add GICv2 specific ACPI boot support",
>     which will cause compile error on i386 with both DT and ACPI
>     enabled:

All 23 patches:

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
