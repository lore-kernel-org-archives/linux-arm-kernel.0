From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 21:58:37 -0500
Subject: [PATCH v6 03/10] irqchip/gic-v2: Gather ACPI specific data in a
 single structure
In-Reply-To: <1460388780-914-4-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-4-git-send-email-julien.grall@arm.com>
Message-ID: <571C365D.80605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> The ACPI code requires to use global variables in order to collect
> information from the tables.
>
> For now, a single global variable is used, but more will be added in a
> subsequent patch. To make clear they are ACPI specific, gather all the
> information in a single structure.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christofer Dall <christoffer.dall@linaro.org>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server platform.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
