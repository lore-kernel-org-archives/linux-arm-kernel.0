From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 22:02:35 -0500
Subject: [PATCH v6 06/10] irqchip/gic-v3: Gather all ACPI specific data in
 a single structure
In-Reply-To: <1460388780-914-7-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-7-git-send-email-julien.grall@arm.com>
Message-ID: <571C374B.503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> The ACPI code requires to use global variables in order to collect
> information from the tables.
>
> To make clear those variables are ACPI specific, gather all of them in a
> single structure.
>
> Furthermore, even if some of the variables are not marked with
> __initdata, they are all only used during the initialization. Therefore,
> the new variable, which hold the structure, can be marked with
> __initdata.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server platform.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
